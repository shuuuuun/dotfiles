set number
syntax on

set nocompatible
filetype off

" NeoBundle
if isdirectory(expand('~/.vim/bundle'))

  "NeoBundle Scripts-----------------------------
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath^=~/.vim/bundle/neobundle.vim/

  " Required:
  call neobundle#begin(expand('~/.vim/bundle'))

  " Let NeoBundle manage NeoBundle
  " Required:
  NeoBundleFetch 'Shougo/neobundle.vim'


  " Add or remove your Bundles here:
  " NeoBundle 'Shougo/neosnippet.vim'
  " NeoBundle 'Shougo/neosnippet-snippets'
  " NeoBundle 'tpope/vim-fugitive'
  " NeoBundle 'ctrlpvim/ctrlp.vim'
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle "slim-template/vim-slim"
  NeoBundle "digitaltoad/vim-pug"
  NeoBundle 'ConradIrwin/vim-bracketed-paste'
  NeoBundle 'wakatime/vim-wakatime' " TODO: デフォルトオフに
  NeoBundle 'mattn/emmet-vim'
  NeoBundle 'alvan/vim-closetag'

  " color scheme
  " NeoBundle 'w0ng/vim-hybrid'
  " NeoBundle 'nanotech/jellybeans.vim'
  " NeoBundle 'tomasr/molokai'
  " NeoBundle 'sjl/badwolf'
  NeoBundle 'morhetz/gruvbox'


  " You can specify revision/branch/tag.
  " NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

  " Required:
  call neobundle#end()

  " Required:
  filetype plugin indent on

  " If there are uninstalled bundles found on startup,
  " this will conveniently prompt you to install them.
  NeoBundleCheck
  " End NeoBundle Scripts-------------------------


  " Depending on NeoBundle

  " color scheme
  autocmd ColorScheme * highlight Normal ctermbg=none
  colorscheme gruvbox
  
  " 隠しファイルをデフォルトで表示させる
  let NERDTreeShowHidden = 1
  
  " デフォルトでツリーを表示させる
  "autocmd VimEnter * execute 'NERDTree'

  " Ctrl+eでNERDTreeをトグル
  nnoremap <silent><C-e> :NERDTreeToggle<CR>
endif


"
" keymap
"

" normal & visual modeでの行頭行末移動
noremap 6 ^
noremap 4 $
noremap 1 ^
noremap 9 $

" insert modeでの行頭行末移動
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$

" insert modeでのカーソル移動
inoremap <C-j> <C-g>j
inoremap <C-k> <C-g>k
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>l

" insert modeでctrl+dで削除
inoremap <C-d> <C-o>x

" 削除キーでyankしない
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D


"
" alias
"
" 終了コマンドをエイリアス
:command Q q

" wもよく大文字にしちゃうので
:command W w
:command Wq wq


"
" settings
"
set expandtab
set tabstop=2
set shiftwidth=2

set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

set cursorline

" set clipboard=unnamed,autoselect
set clipboard=unnamed

" 左右のカーソル移動で行間移動可能にする
set whichwrap=b,s,h,l,<,>,[,],~

" いつのまにかdelete(backspace)がうまく効かなくなったので設定
set backspace=indent,eol,start

" バックアップファイル（hoge.swpやhoge~やhoge.un~）を１箇所にまとめる
if !isdirectory(expand('~/.vim/backup'))
  call mkdir(expand('~/.vim/backup'), 'p')
endif
set directory=~/.vim/backup
set backupdir=~/.vim/backup
set undodir=~/.vim/backup
