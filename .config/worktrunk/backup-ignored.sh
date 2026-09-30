#!/usr/bin/env bash
#
# worktrunk の pre-remove フックから呼ばれ、削除される worktree の ignore ファイル（.env など）を退避する。
# 依存ライブラリ・キャッシュ・ビルド成果物は除外する。
#
# 使い方: backup-ignored.sh <primary_worktree_path> <branch>
#   cwd は削除される worktree のルートであること（pre-remove フックの実行ディレクトリ）
#
# 退避先: <primary_worktree_path>/.worktrees/.backup/<YYYYmmdd_HHMMSS>_<branch>/

set -euo pipefail

MAX_BYTES=$((1024 * 1024))

# パスの要素のいずれかがこれに一致したら除外する（glob 可）
EXCLUDES=(
  node_modules
  vendor
  .venv
  venv
  __pycache__
  .next
  .nuxt
  dist
  build
  target
  .cache
  .turbo
  coverage
  .pytest_cache
  .mypy_cache
  .terraform
  tmp
  log
  .worktrees
  .DS_Store
  '*.log'
)

if [ $# -ne 2 ]; then
  echo "usage: $(basename "$0") <primary_worktree_path> <branch>" >&2
  exit 2
fi
primary_worktree_path=$1
branch=$2

is_excluded() {
  local parts part pattern
  IFS=/ read -r -a parts <<< "$1"
  for part in "${parts[@]}"; do
    for pattern in "${EXCLUDES[@]}"; do
      # shellcheck disable=SC2053
      [[ $part == $pattern ]] && return 0
    done
  done
  return 1
}

files=()
add_file() {
  is_excluded "$1" || files+=("$1")
}

while IFS= read -r -d '' entry; do
  entry=${entry%/}
  is_excluded "$entry" && continue
  if [ -d "$entry" ] && [ ! -L "$entry" ]; then
    while IFS= read -r -d '' f; do
      add_file "${f#./}"
    done < <(find "$entry" \( -type f -o -type l \) -print0)
  else
    add_file "$entry"
  fi
done < <(git ls-files -z --ignored --exclude-standard --others --directory --no-empty-directory)

if [ ${#files[@]} -eq 0 ]; then
  exit 0
fi

oversized=()
for f in "${files[@]}"; do
  [ -L "$f" ] && continue
  size=$(wc -c < "$f" | tr -d ' ')
  if [ "$size" -gt "$MAX_BYTES" ]; then
    oversized+=("$f ($size bytes)")
  fi
done

if [ ${#oversized[@]} -gt 0 ]; then
  echo "backup-ignored: 上限 ${MAX_BYTES} bytes を超える ignore ファイルがあるため中断しました:" >&2
  printf '  %s\n' "${oversized[@]}" >&2
  echo "除外するには $0 の EXCLUDES に追加してください。" >&2
  echo "退避せずに削除するには wt remove --no-hooks を使ってください。" >&2
  exit 1
fi

dest="$primary_worktree_path/.worktrees/.backup/$(date +%Y%m%d_%H%M%S)_$branch"
mkdir -p "$dest"
for f in "${files[@]}"; do
  mkdir -p "$dest/$(dirname "$f")"
  cp -pP "$f" "$dest/$f"
done

echo "backup-ignored: ${#files[@]} 件を $dest に退避しました:"
printf '  %s\n' "${files[@]}"
