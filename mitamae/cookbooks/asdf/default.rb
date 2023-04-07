# https://github.com/asdf-vm/asdf
# https://asdf-vm.com/guide/getting-started.html

asdf_dir = "#{node["home_dir"]}/.asdf"
plugins = node["asdf"]["plugins"]

git asdf_dir do
  repository "https://github.com/asdf-vm/asdf.git"
end

plugins.each do |name, version|
  execute "asdf add plugin(#{name})" do
    command "#{asdf_dir}/bin/asdf plugin add #{name}"
    not_if "#{asdf_dir}/bin/asdf plugin list | grep #{name}"
  end

  execute "asdf install #{name} #{version}" do
    command "#{asdf_dir}/bin/asdf install #{name} #{version}"
  end
end

execute "asdf update all plugins" do
  command "#{asdf_dir}/bin/asdf plugin update --all"
end
