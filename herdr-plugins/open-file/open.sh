#!/bin/sh
# Ctrl+クリックされた file:// リンクを macOS の open で開く。
# herdr は標準出力をプラグインログ（herdr plugin log list）に残すため、どの分岐でも理由を出力する。

set -eu

say() { printf '%s\n' "$*"; }

is_num() { case $1 in '' | *[!0-9]*) return 1 ;; esac; }

url="${HERDR_PLUGIN_CLICKED_URL:-}"
case $url in
  file://*) rest=${url#file://} ;;
  *) say "skip: not a file link: $url"; exit 0 ;;
esac

# file:///abs はホストなし、file://localhost/abs や file://<hostname>/abs はホスト付き
case $rest in
  /*) ;;
  *) rest=/${rest#*/} ;;
esac

# %XX を \xXX にして printf %b でデコードする。ファイル名中の \ が %b に解釈されないよう先にエスケープする
p=$(printf '%s' "$rest" | sed -e 's/\\/\\\\/g' -e 's/%\([0-9A-Fa-f][0-9A-Fa-f]\)/\\x\1/g')
p=$(printf '%b' "$p")

# :line[:col] はそのパスが存在しないときだけ外す。コロンを含むファイル名を壊さないため
if [ ! -e "$p" ] && is_num "${p##*:}"; then
  p=${p%:*}
  if [ ! -e "$p" ] && is_num "${p##*:}"; then
    p=${p%:*}
  fi
fi

# リンクはどのプログラムでも出力できるため、実在するローカルパスだけを開く
[ -e "$p" ] || { say "skip: no such path: $p"; exit 0; }

# 端末によっては 1 回の Ctrl+クリックが 2 回届く（herdr#3720）ため、同じパスへの短時間の再実行は捨てる
stamp="${HERDR_PLUGIN_STATE_DIR:-${TMPDIR:-/tmp}}/last-open"
now=$(date +%s)
if [ -f "$stamp" ]; then
  IFS=' ' read -r last_time last_path < "$stamp" || true
  if [ "${last_path:-}" = "$p" ] && [ $((now - ${last_time:-0})) -le 1 ]; then
    say "skip: duplicate activation: $p"
    exit 0
  fi
fi
printf '%s %s\n' "$now" "$p" > "$stamp"

# リンクの表示文字列と行き先は別にできるため、.app や .command など開くと実行されるものを既定アプリに渡さない。
# 文書・画像だけを既定アプリで開き、それ以外は Finder で選択表示するだけにする。
# open はシンボリックリンクの行き先の種類で開くため、行き先を解決してから拡張子を判定する
p=$(realpath "$p")
if [ -f "$p" ] && [ ! -x "$p" ]; then
  ext=$(printf '%s' "${p##*.}" | tr '[:upper:]' '[:lower:]')
  case $ext in
    md | txt | pdf | csv | tsv | log | png | jpg | jpeg | gif | webp | svg | heic)
      say "open: $p"
      exec open "$p"
      ;;
  esac
fi

say "reveal: $p"
exec open -R "$p"
