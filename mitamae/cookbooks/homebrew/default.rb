# ref. https://brew.sh/index_ja
execute "install homebrew" do
  command '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  not_if "which brew"
end
