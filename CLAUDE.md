# dotfiles リポジトリのルール

## コミットメッセージ規約

### フォーマット

```
<scope>: <subject>

<body（任意）>
```

- **scope**: 変更対象のツール・ディレクトリ名。どこを変更したか一目で分かるようにする
  - 例: `sh`, `zsh`, `git`, `tmux`, `tig`, `mitamae`, `brew`, `vim`, `lf`, `bin`, `vscode`, `claude`
  - 新規ツールの追加・削除や、1 つの目的で複数ツールの設定にまたがる変更は scope を省略してよい（例: `add asdf`, `remove lima`, `add herdr-radar`）
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
- コミットは目的ごとに分割すること。1 つの目的が複数ツールの設定に波及する場合（例: プラグイン導入に伴うターミナル側のフォント設定）は 1 コミットにまとめる
