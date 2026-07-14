#!/usr/bin/env bash
#
# pack_secrets.sh
# ~/.ssh, ~/.aws など認証情報系ディレクトリ/ファイルをtar+gpgで暗号化し、
# AirDrop等で新端末に安全に転送するためのアーカイブを作成する。
#
# 使い方:
#   ./pack_secrets.sh
#   (対象は下の TARGETS 配列を編集して指定)
#
# 新端末側での展開は unpack_secrets.sh を使う(.gpg と一緒に Desktop へコピーされる)。

set -euo pipefail
umask 077

# ── 転送したい対象をここに列挙(~/ からの相対パス、存在しないものは自動でスキップ) ──
TARGETS=(
  ".ssh/"
  ".aws/config"
  ".aws/credentials"
  ".agents/"
  ".claude/projects/"
  ".claude/skills/"
  ".claude/CLAUDE.md"
  ".claude/settings.json"
  # ".colima/"
  # ".config/"
  ".tmux/"
  ".zsh_history"
)

OUTDIR="$HOME/Desktop"
STAMP="$(date +%Y%m%d_%H%M%S)"
ARCHIVE_NAME="secrets_backup_${STAMP}"
GPG_PATH="${OUTDIR}/${ARCHIVE_NAME}.tar.gz.gpg"

echo "==> 以下の対象をアーカイブします(~ からの相対パス):"
existing_targets=()
for t in "${TARGETS[@]}"; do
  if [ -e "$HOME/$t" ]; then
    echo "  [OK]      $t"
    existing_targets+=("$t")
  else
    echo "  [SKIP]    $t (存在しないため)"
  fi
done

if [ ${#existing_targets[@]} -eq 0 ]; then
  echo "対象が1つも見つかりませんでした。TARGETS の内容を確認してください。" >&2
  exit 1
fi

echo
echo "==> tar でまとめて gpg で対称鍵暗号化します。パスフレーズを入力してください(2回)。"
# pinentry が端末を見つけられるようにする(未設定だと Inappropriate ioctl for device で失敗する)
export GPG_TTY="${GPG_TTY:-$(tty)}"
# 平文の tar.gz をディスクに書かないよう gpg へ直接パイプする。
# -h: symlink はリンクではなく実体を格納する(dotfiles 管理のファイル対策)
tar czhf - -C "$HOME" "${existing_targets[@]}" | gpg --symmetric --cipher-algo AES256 -o "$GPG_PATH"

# 新端末側で使う展開スクリプトも一緒に転送できるよう Desktop にコピーする
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp "$SCRIPT_DIR/unpack_secrets.sh" "$OUTDIR/unpack_secrets.sh"

cat <<EOF

完成しました。以下の2ファイルを AirDrop で新しいMacに送ってください:
  $GPG_PATH
  $OUTDIR/unpack_secrets.sh

----------------------------------------------------------------
新端末側での展開手順:
  1. gpg が無ければインストール: brew install gnupg
  2. 受信したフォルダで展開スクリプトを実行:
       cd ~/Downloads
       bash unpack_secrets.sh ${ARCHIVE_NAME}.tar.gz.gpg
     ※ 既存ファイルと衝突する場合は何も展開せずエラー終了する
  3. 「OK: 展開しました」が出たら、表示される案内に従って後始末する
----------------------------------------------------------------

旧端末側でも、転送が完了して確認できたら以下で後始末してください:
  rm "$GPG_PATH" "$OUTDIR/unpack_secrets.sh"
EOF
