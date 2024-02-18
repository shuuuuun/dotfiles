package 'git'

# https://github.com/git/git/tree/master/contrib/diff-highlight
# TODO: 環境によってパスが変わるが、特定方法がわからないので羅列している
diff_highlight_paths = %w[
  /usr/share/doc/git/contrib/diff-highlight/diff-highlight
  /usr/local/share/git-core/contrib/diff-highlight/diff-highlight
  /opt/homebrew/share/git-core/contrib/diff-highlight/diff-highlight
]
diff_highlight_paths.each do |path|
  # ファイルがあったらsymlinkを作成
  link "/usr/local/bin/diff-highlight" do # "/path/of/destination"
    to path # "/path/of/source"
    user "root"
    only_if "ls #{path}"
    not_if "which /usr/local/bin/diff-highlight"
  end
end
