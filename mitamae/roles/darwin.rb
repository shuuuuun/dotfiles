include_cookbook "homebrew"

execute "update packages" do
  command "brew update"
end
