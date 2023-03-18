node.reverse_merge!(
  home_dir: "/home/#{current_user}",
  anyenv: {
    root_dir: "/home/#{current_user}/.anyenv",
    owner: "#{current_user}",
    group: "#{current_user}",
  },
  tmux: {
    version: "3.1c",
    prefix: "/usr/local",
    profile: "/etc/profile",
  },
  libevent: {
    version: "2.1.12",
  },
  ncurses: {
    version: "6.2",
  }
)

execute "update packages" do
  command "sudo apt-get update"
end

include_cookbook 'git'
include_cookbook 'vim'
include_cookbook 'tig'
include_cookbook 'anyenv'

# include_recipe 'tmux'
# include_recipe 'docker::install'

# include_cookbook 'mosh'
# include_cookbook 'ghq'
# include_cookbook 'zsh'
# include_cookbook 'peco'
# include_cookbook 'local-accounts'
# include_recipe 'ssh-agent'


# gem install solargraph


# change login shell
#   sudo chsh -s $(which zsh)
