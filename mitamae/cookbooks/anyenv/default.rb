# ref. https://github.com/anyenv/anyenv

anyenv_dir = node["anyenv"]["root_dir"]

git anyenv_dir do
  repository "https://github.com/anyenv/anyenv"
end

directory "#{anyenv_dir}/plugins" do
  not_if "test -d #{anyenv_dir}/plugins"
end

git "#{anyenv_dir}/plugins/anyenv-update" do
  repository "https://github.com/znz/anyenv-update"
end

# $ echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bashrc
# $ echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.zshrc

# $ ~/.anyenv/bin/anyenv init
