# https://github.com/asdf-vm/asdf
# https://asdf-vm.com/guide/getting-started.html
# asdf v0.16 以降は Go 製バイナリになり、git clone では動かない。
# darwin では Homebrew でインストールし、それ以外は GitHub Releases のバイナリを ~/.local/bin に置く。

plugins = node["asdf"]["plugins"]

if node[:platform] == "darwin"
  execute "install asdf" do
    command "brew install asdf"
    not_if "which asdf"
  end

  asdf_bin = "asdf"
else
  asdf_version = node["asdf"]["version"] || "0.18.0"
  bin_dir = "#{node["home_dir"]}/.local/bin"
  asdf_bin = "#{bin_dir}/asdf"

  directory bin_dir do
    action :create
  end

  execute "install asdf v#{asdf_version}" do
    command "arch=$(uname -m); " \
            "case \"$arch\" in x86_64) arch=amd64 ;; aarch64) arch=arm64 ;; esac; " \
            "curl -fsSL https://github.com/asdf-vm/asdf/releases/download/v#{asdf_version}/asdf-v#{asdf_version}-linux-${arch}.tar.gz " \
            "| tar -xz -C #{bin_dir}"
    not_if "#{asdf_bin} version | grep #{asdf_version}"
  end
end

plugins.each do |name, version|
  execute "asdf add plugin(#{name})" do
    command "#{asdf_bin} plugin add #{name}"
    not_if "#{asdf_bin} plugin list | grep #{name}"
  end

  execute "asdf install #{name} #{version}" do
    command "#{asdf_bin} install #{name} #{version}"
  end
end

execute "asdf update all plugins" do
  command "#{asdf_bin} plugin update --all"
end
