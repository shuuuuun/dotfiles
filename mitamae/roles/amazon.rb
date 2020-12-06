node.reverse_merge!(
  tmux: {
    version: "3.1c",
  },
  libevent: {
    version: "2.1.12",
  },
  ncurses: {
    version: "6.2",
  }
)

include_cookbook 'git'
include_cookbook 'vim'
include_cookbook 'tig'
# include_cookbook 'tmux'
include_recipe 'tmux'
# include_cookbook 'anyenv'
# include_cookbook 'docker'
# include_cookbook 'mosh'
# include_cookbook 'ghq'
# include_cookbook 'zsh'
# include_cookbook 'peco'
# include_cookbook 'local-accounts'
# include_recipe 'ssh-agent'
