current_user = `whoami`.strip
puts "current_user: #{current_user}"
home_dir = `echo $HOME`.strip
puts "home_dir: #{home_dir}"

node.reverse_merge!(
  home_dir: "#{home_dir}",
  asdf: {
    plugins: [
      "ruby",
      "nodejs",
    ]
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
# include_cookbook 'anyenv'
include_cookbook 'asdf'

# include_recipe 'tmux'
# include_recipe 'docker::install'

# include_cookbook 'mosh'
# include_cookbook 'ghq'
# include_cookbook 'zsh'
# include_cookbook 'peco'
# include_cookbook 'local-accounts'
# include_recipe 'ssh-agent'

gems = %w[solargraph]
execute "install gems" do
  command "gem install #{gems.join(" ")}"
end
