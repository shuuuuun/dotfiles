# https://github.com/asdf-vm/asdf
# https://asdf-vm.com/guide/getting-started.html

asdf_dir = "#{node["home_dir"]}/.asdf"
plugins = node["asdf"]["plugins"]

git asdf_dir do
  repository "https://github.com/asdf-vm/asdf.git"
end

plugins.each do |plugin|
  execute "asdf add plugin(#{plugin})" do
    command "asdf plugin add #{plugin}"
    not_if "asdf plugin list | grep #{plugin}"
  end

  execute "asdf install latest(#{plugin})" do
    command "asdf install #{plugin} latest"
  end
end

execute "asdf update all plugins" do
  command "asdf plugin update --all"
end
