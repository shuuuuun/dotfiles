#!/bin/sh
# Claude Code の Stop hook から呼び、ペインの端末タイトルを herdr のタブ名に反映する。
# 1タブに Claude Code を1つだけ置く運用が前提で、手で付けたタブ名も上書きする。

cat >/dev/null

[ "${HERDR_ENV:-}" = "1" ] || exit 0
[ -n "${HERDR_PANE_ID:-}" ] || exit 0
[ -n "${HERDR_TAB_ID:-}" ] || exit 0
command -v herdr >/dev/null 2>&1 || exit 0
command -v jq >/dev/null 2>&1 || exit 0

title="$(herdr pane get "$HERDR_PANE_ID" 2>/dev/null | jq -r '.result.pane.terminal_title_stripped // empty')"

# タイトル未生成のときは "Claude Code" 固定で作業内容を表さない
case "$title" in
  ''|'Claude Code') exit 0 ;;
esac

label="$(herdr tab get "$HERDR_TAB_ID" 2>/dev/null | jq -r '.result.tab.label // empty')"
[ "$label" = "$title" ] && exit 0

herdr tab rename "$HERDR_TAB_ID" "$title" >/dev/null 2>&1 || true
exit 0
