current_user = `whoami`.strip
puts "current_user: #{current_user}"
home_dir = `echo $HOME`.strip
puts "home_dir: #{home_dir}"

node.reverse_merge!(
  home_dir: "#{home_dir}",
  asdf: {
    plugins: {
      "ruby" => "latest",
      "nodejs" => "lts",
    }
  },
)

include_cookbook "homebrew"

# execute "update packages" do
#   command "brew update"
# end

brewfile_core = File.expand_path("../../../Brewfile.core", __FILE__)

execute "install bundle packages (core)" do
  command "brew bundle install --file=#{brewfile_core}"
  not_if "brew bundle check --file=#{brewfile_core}"
end

include_cookbook "asdf"
# include_cookbook "anyenv"
include_cookbook "rustup"


# TODO: ruby YJIT enabled
# RUBY_CONFIGURE_OPTS=--enable-yjit rbenv install 3.2.1
# ruby --yjit -ve 'p RubyVM::YJIT.enabled?'

# TODO: install docker
# brew install docker
# brew install docker-compose
# brew install docker-buildx
# mkdir -p ~/.docker/cli-plugins
# ln -sfn /opt/homebrew/bin/docker-compose ~/.docker/cli-plugins/docker-compose
# ln -sfn /opt/homebrew/bin/docker-buildx ~/.docker/cli-plugins/
