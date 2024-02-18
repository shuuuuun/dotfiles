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

# execute "install bundle packages" do
#   command "brew bundle install"
#   not_if "brew bundle check"
# end

include_cookbook "asdf"
# include_cookbook "anyenv"
include_cookbook "rustup"


# TODO: ruby YJIT enabled
# RUBY_CONFIGURE_OPTS=--enable-yjit rbenv install 3.2.1
# ruby --yjit -ve 'p RubyVM::YJIT.enabled?'
