#!/bin/sh
# popup を開いたペインの作業ディレクトリを出力する。
# Claude Code のペインでは、hook（~/.claude/hooks/report-cwd.sh）がペインごとのファイルに記録した作業ディレクトリを優先する。
# claude プロセスの cwd である HERDR_ACTIVE_PANE_CWD は起動時のディレクトリのままで、worktree などへの移動を反映しないため。

fallback="${HERDR_ACTIVE_PANE_CWD:-$PWD}"
state_file="${XDG_STATE_HOME:-$HOME/.local/state}/herdr-claude-cwd/${HERDR_ACTIVE_PANE_ID:-}"

if [ -n "${HERDR_ACTIVE_PANE_ID:-}" ] && [ -f "$state_file" ] && command -v jq >/dev/null 2>&1; then
  # Claude 終了後のシェルや、同じ pane id を再利用した別プロセスに古い記録が残っていても使わないよう、agent が claude のときだけ採用する
  agent="$(herdr pane get "$HERDR_ACTIVE_PANE_ID" 2>/dev/null | jq -r '.result.pane.agent // empty' 2>/dev/null)"
  dir="$(cat "$state_file" 2>/dev/null)"
  if [ "$agent" = "claude" ] && [ -n "$dir" ] && [ -d "$dir" ]; then
    printf '%s\n' "$dir"
    exit 0
  fi
fi

printf '%s\n' "$fallback"
