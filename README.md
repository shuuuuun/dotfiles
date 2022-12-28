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
