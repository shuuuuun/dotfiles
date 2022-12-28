include_cookbook "homebrew"

execute "update packages" do
  command "brew update"
end

execute "install bundle packages" do
  command "brew bundle install"
  not_if "brew bundle check"
end

include_cookbook "anyenv"
