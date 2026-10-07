#!/bin/bash
# フォーカス中のタブの 2 ペイン分割を、左右と上下で切り替える。
# herdr 0.9.3 には分割方向を変える API がなく、同じタブ内の pane move も no-op になるため、
# 一度新しいタブへ出してから元のタブへ戻す。プロセスは pane move で生きたまま引き継がれる。
# 分割が入れ子になる 3 ペイン以上のタブでは向きが 1 つに決まらないので何もしない。

set -eu

# keys.command の type = "shell" はログインシェルの PATH を引き継がない
PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

layout=$(herdr pane layout | jq -c '.result.layout')

[ "$(printf '%s' "$layout" | jq '.panes | length')" -eq 2 ] || exit 0

tab_id=$(printf '%s' "$layout" | jq -r '.tab_id')
direction=$(printf '%s' "$layout" | jq -r '.splits[0].direction')
ratio=$(printf '%s' "$layout" | jq -r '.splits[0].ratio')
# 左（上）のペインを残し、右（下）のペインを移す
target=$(printf '%s' "$layout" | jq -r '.panes | sort_by(.rect.x, .rect.y) | .[0].pane_id')
moving=$(printf '%s' "$layout" | jq -r '.panes | sort_by(.rect.x, .rect.y) | .[1].pane_id')
moving_focused=$(printf '%s' "$layout" | jq -r --arg id "$moving" '.panes[] | select(.pane_id == $id) | .focused')

case "$direction" in
  right) new_direction=down ;;
  down) new_direction=right ;;
  *) exit 0 ;;
esac

focus_flag=--no-focus
[ "$moving_focused" = "true" ] && focus_flag=--focus

moved=$(herdr pane move "$moving" --new-tab --no-focus | jq -r '.result.move_result.pane.pane_id')
herdr pane move "$moved" --tab "$tab_id" --target-pane "$target" --split "$new_direction" --ratio "$ratio" "$focus_flag" >/dev/null
