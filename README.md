# dotfiles

### install
```sh
curl -L dot.shuuuuun.com/bin/install.sh | bash

# same as:
curl https://raw.githubusercontent.com/shuuuuun/dotfiles/master/bin/install.sh | bash
```

### minimal install
```sh
curl -L dot.shuuuuun.com/bin/minimal.sh | bash

# same as:
curl https://raw.githubusercontent.com/shuuuuun/dotfiles/master/bin/minimal.sh | bash
```


### secret scanning

このリポジトリはpublicなので、`.githooks/` のフックで秘密情報の混入をチェックしている
(`core.hooksPath` は `bin/install.sh` で設定される)。

| タイミング | 手段 | 役割 |
| --- | --- | --- |
| commit | `.githooks/pre-commit` | ホームディレクトリの絶対パスと、gitleaks で検出できるシークレット(APIキー/秘密鍵など)を落とす |
| push | `.githooks/pre-push` | 判断が要るもの(社内ホスト名/実名/内部URLなど)を `claude -p` でAIレビューする |
| GitHub側 | Secret Scanning + Push Protection | 既知形式のトークンをサーバ側で弾く最終防衛線 |

- gitleaks は `brew install gitleaks` で入れる(無い環境では git-secrets にフォールバック)
- 誤検知は `.gitleaks.toml` の allowlist に追加する(実在しないサンプル値だけにすること)
- GitHub側は Settings → Code security で "Secret scanning" と "Push protection" をONにする(publicリポジトリは無料)
- スキップしたいとき: `git commit --no-verify` / `DOTFILES_SKIP_AI_REVIEW=1 git push`(または `git push --no-verify`)
- AIレビューは push 対象の差分を Anthropic の API に送信する。`claude` が無い環境では警告だけ出して push を通し、レビューが完了しなかった場合(APIエラー等)は push を止める

### note

- change login shell
  ```sh
  sudo chsh -s $(which zsh)
  ```
- homebrew-bundle
  - install: `brew bundle install`
  - dump: `brew bundle dump --describe --force`
  - check: `brew bundle check --verbose`
  - ref. https://github.com/Homebrew/homebrew-bundle
