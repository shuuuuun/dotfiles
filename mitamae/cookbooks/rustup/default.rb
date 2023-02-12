# ref. https://www.rust-lang.org/ja/tools/install
execute "install rustup" do
  command "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"
  not_if "which rustup"
end

execute "update rustup" do
  command "rustup update"
end

local_ruby_block "rustc --version" do
  block do
    result = run_command "rustc --version"
    puts "rustc version: #{result.stdout}"
  end
end
