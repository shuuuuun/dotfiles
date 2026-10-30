#!/bin/sh
# ペインで選択したパスを macOS の Quick Look で開く。
# herdr はペインのテキストを選択した時点でクリップボードへコピーするため、選択内容は pbpaste で読む。
# keys.command の type = "shell" には選択テキストが渡されない（渡されるのは plugin_action だけ）。

set -eu

PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

path=$(pbpaste | head -n 1)
# 前後の空白と、パスを囲みがちな引用符・バッククォートを外す
path=$(printf '%s' "$path" | sed -e 's/^[[:space:]"'\''`]*//' -e 's/[[:space:]"'\''`]*$//')
path=${path#file://}
case $path in
  "~") path=$HOME ;;
  "~/"*) path=$HOME/${path#"~/"} ;;
esac
case $path in
  /*) ;;
  *) path="$(~/.config/herdr/popup-cwd.sh)/$path" ;;
esac
# コンパイラやエージェントの出力にある path:line:col 形式の末尾を外す
[ -e "$path" ] || path=$(printf '%s' "$path" | sed -E 's/(:[0-9]+){1,2}$//')
[ -e "$path" ] || exit 0

# qlmanage はプレビューを閉じるまで終了しないため、前回のプレビューが残っていれば閉じる
pkill -f '^qlmanage -p ' || true
qlmanage -p "$path" >/dev/null 2>&1 &
pid=$!
# qlmanage のウィンドウは端末の裏に開くため、起動を待ってから前面に出す
sleep 1
osascript -e "tell application \"System Events\" to set frontmost of first process whose unix id is $pid to true" >/dev/null 2>&1 || true
