# ref. https://github.com/anyenv/anyenv

# anyenv_dir          = node["anyenv"]["root_dir"]
anyenv_dir          = "#{node["home_dir"]}/.anyenv"
# anyenv_versions     = node["anyenv"]["versions"]
# anyenv_version      = node["anyenv"]["version"]
anyenv_owner        = node["anyenv"]["owner"]
anyenv_group        = node["anyenv"]["group"]
sudo                = "sudo -u #{anyenv_owner} -i"

# git "~/.anyenv" do
git anyenv_dir do
  repository "https://github.com/anyenv/anyenv"
end

directory "#{anyenv_dir}/plugins" do
  not_if "test -d #{anyenv_dir}/plugins"
end

# git "#{anyenv_dir}/plugins/ruby-build" do
#   repository "git://github.com/sstephenson/ruby-build.git"
# end

# execute "chown #{anyenv_dir}" do
#   command "chown -R #{anyenv_owner}:#{anyenv_group} #{anyenv_dir}"
# end

# $ echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bashrc
# $ echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.zshrc

# $ ~/.anyenv/bin/anyenv init




# anyenv_versions.each do |version|
#   execute "anyenv install #{version}" do
#     command "#{sudo} anyenv install #{version}"
#     not_if  "#{sudo} anyenv versions | grep #{version}"
#   end
# end

# execute "anyenv local #{anyenv_version}" do
#   command "#{sudo} anyenv local #{anyenv_version}"
# end

# execute "anyenv global #{anyenv_version}" do
#   command "#{sudo} anyenv global #{anyenv_version}"
# end

# execute "gem install bundler" do
#   command "#{sudo} gem install bundler"
#   not_if  "#{sudo} gem list | grep bundler"
# end
