#!/bin/sh
# Claude Code の Stop hook から呼び、ペインの端末タイトルを herdr のタブ名に反映する。
# 1タブに Claude Code を1つだけ置く運用が前提で、タブ名が既定の連番のときだけ書き換える。
# 一度書き換えると連番ではなくなるため、その後のタイトル変更には追従しない。

cat >/dev/null

[ "${HERDR_ENV:-}" = "1" ] || exit 0
[ -n "${HERDR_PANE_ID:-}" ] || exit 0
[ -n "${HERDR_TAB_ID:-}" ] || exit 0
command -v herdr >/dev/null 2>&1 || exit 0
command -v jq >/dev/null 2>&1 || exit 0

# herdr の tab API には既定名かどうかのフィールドがなく、既定名は作成時の連番（tab の number とは一致しないことがある）
label="$(herdr tab get "$HERDR_TAB_ID" 2>/dev/null | jq -r '.result.tab.label // empty')"
case "$label" in
  ''|*[!0-9]*) exit 0 ;;
esac

title="$(herdr pane get "$HERDR_PANE_ID" 2>/dev/null | jq -r '.result.pane.terminal_title_stripped // empty')"

# タイトル未生成のときは "Claude Code" 固定で、ここで書き換えると連番でなくなり以後追従できない
case "$title" in
  ''|'Claude Code') exit 0 ;;
esac

herdr tab rename "$HERDR_TAB_ID" "$title" >/dev/null 2>&1 || true
exit 0
