# dotfiles リポジトリのルール

## コミットメッセージ規約

### フォーマット

```
<scope>: <subject>

<body（任意）>
```

- **scope**: 変更対象のツール・ディレクトリ名。どこを変更したか一目で分かるようにする
  - 例: `sh`, `zsh`, `git`, `tmux`, `tig`, `mitamae`, `brew`, `vim`, `lf`, `bin`, `vscode`, `claude`
  - 新規ツールの追加・削除やリポジトリ横断的な変更は scope を省略してよい（例: `add asdf`, `remove lima`）
- **subject**: 原則として英語。50字程度まで
- **body**: 補足説明が必要な場合に日本語で書く。実行したコマンドをそのまま載せるのも可（例: `$ brew bundle dump --force`）

### 例

```
mitamae: support asdf v0.16+ (Go rewrite)

asdfはv0.16でGo製に書き換えられ、git cloneではbin/asdfが存在しなくなった。
darwinはHomebrew、それ以外はGitHub Releasesのバイナリをインストールするように変更。
```

```
brew: update Brewfile

$ brew bundle dump --force --no-vscode --no-go --no-npm --no-mas
```

### 注意

- `feat:`, `fix:` などの Conventional Commits プレフィックスは使わない
- コミットは内容（scope）ごとに分割すること
