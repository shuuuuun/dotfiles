#!/bin/sh
# Claude Code の SessionStart / CwdChanged / SessionEnd hook から呼び、Claude の作業ディレクトリをペインごとのファイルに記録する。
# claude プロセス自体の cwd は起動時のディレクトリから変わらず、worktree への移動などは herdr の pane cwd に現れないため。
# herdr の pane メタデータのトークンは値が 80 文字で切り詰められ、長いパスを保持できないためファイルにしている。
# 読み手は ~/.config/herdr/popup-cwd.sh。

action="${1:-report}"
input="$(cat)"

[ "${HERDR_ENV:-}" = "1" ] || exit 0
[ -n "${HERDR_PANE_ID:-}" ] || exit 0

state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/herdr-claude-cwd"
state_file="$state_dir/$HERDR_PANE_ID"

if [ "$action" = "clear" ]; then
  rm -f "$state_file"
  exit 0
fi

command -v jq >/dev/null 2>&1 || exit 0
cwd="$(printf '%s' "$input" | jq -r '.cwd // empty' 2>/dev/null)"
[ -n "$cwd" ] || exit 0

# resume した Claude は起動したディレクトリ（herdr が復元したペインの cwd）から始まり、中断前に作業していた worktree などには戻らない。
# popup は作業していた場所で開きたいので、transcript に残る最後の cwd を使う。
# transcript の形式は Claude Code の内部仕様のため、読めなければ hook の cwd のままにする。
source="$(printf '%s' "$input" | jq -r '.source // empty' 2>/dev/null)"
transcript="$(printf '%s' "$input" | jq -r '.transcript_path // empty' 2>/dev/null)"
if [ "$source" = "resume" ] && [ -f "$transcript" ]; then
  last="$(tail -n 500 "$transcript" | jq -r 'select(type == "object" and (.cwd | type) == "string") | .cwd' 2>/dev/null | tail -n 1)"
  [ -n "$last" ] && [ -d "$last" ] && cwd="$last"
fi

mkdir -p "$state_dir" && printf '%s\n' "$cwd" > "$state_file.$$" && mv "$state_file.$$" "$state_file"
exit 0
