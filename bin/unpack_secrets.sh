#!/usr/bin/env bash
#
# unpack_secrets.sh
# pack_secrets.sh が作成した .tar.gz.gpg を復号してホームディレクトリに展開する。
# 展開前に既存ファイルとの衝突をチェックし、1つでも衝突があれば何も展開せずエラー終了する。
#
# 使い方(新端末側):
#   bash unpack_secrets.sh secrets_backup_YYYYMMDD_HHMMSS.tar.gz.gpg
#
# gpg を2回呼ぶが、パスフレーズは gpg-agent がキャッシュするため通常1回の入力で済む。

set -euo pipefail
umask 077

if ! command -v gpg >/dev/null 2>&1; then
  echo "NG: gpg が見つかりません。先にインストールしてください: brew install gnupg" >&2
  exit 1
fi

if [ $# -ne 1 ]; then
  echo "使い方: bash $0 <secrets_backup_*.tar.gz.gpg>" >&2
  exit 1
fi

ARCHIVE="$1"
if [ ! -f "$ARCHIVE" ]; then
  echo "NG: ファイルが見つかりません: $ARCHIVE" >&2
  exit 1
fi

# pinentry が端末を見つけられるようにする(未設定だと Inappropriate ioctl for device で失敗する)
export GPG_TTY="${GPG_TTY:-$(tty)}"

echo "==> 復号してアーカイブの内容を確認します。パスフレーズを入力してください。"
list="$(gpg -d "$ARCHIVE" | tar tzf -)"
if [ -z "$list" ]; then
  echo "NG: アーカイブが空です" >&2
  exit 1
fi

conflicts="$(printf '%s\n' "$list" | while read -r p; do
  if [ -e "$HOME/$p" ] && [ ! -d "$HOME/$p" ]; then
    echo "  ~/$p"
  fi
done)"
if [ -n "$conflicts" ]; then
  echo "NG: 以下の既存ファイルと衝突するため、何も展開せずに終了します:" >&2
  printf '%s\n' "$conflicts" >&2
  exit 1
fi

echo "==> ~ に展開します..."
gpg -d "$ARCHIVE" | tar xzf - -C "$HOME"

echo "==> パーミッションを整えます..."
chmod 700 "$HOME/.ssh" "$HOME/.aws" "$HOME/.gnupg" 2>/dev/null || true
chmod 600 "$HOME"/.ssh/id_* "$HOME/.aws/credentials" 2>/dev/null || true

echo "OK: 展開しました"
echo "確認できたらアーカイブを削除してください: rm \"$ARCHIVE\""
echo "(AirDrop で受け取った unpack_secrets.sh も不要になったら削除する)"
