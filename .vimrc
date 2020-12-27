"
" settings
"
set number
syntax on

set nocompatible
filetype off

set expandtab
set tabstop=2
set shiftwidth=2

" 不可視文字を表示
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

set cursorline

" set clipboard=unnamed,autoselect
set clipboard=unnamed

" 検索時に大文字を含んでいたら大/小を区別
set smartcase

" 新しい行を作ったときに自動インデント
set smartindent

" 左右のカーソル移動で行間移動可能にする
set whichwrap=b,s,h,l,<,>,[,],~

" delete(backspace)
set backspace=indent,eol,start

" バックアップファイル（hoge.swpやhoge~やhoge.un~）を１箇所にまとめる
if !isdirectory(expand('~/.vim/backup'))
  call mkdir(expand('~/.vim/backup'), 'p')
endif
set directory=~/.vim/backup
set backupdir=~/.vim/backup
set undodir=~/.vim/backup


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
" inoremap <C-d> <C-o>x
inoremap <C-d> <C-o>"_x

" 削除キーでyankしない
" nnoremap x "_x
" nnoremap d "_d
" nnoremap D "_D
vnoremap d "_d

" normalモードで:;入れ替え
" noremap : ;
" noremap ; :

" 画面分割・タブページまわり
" ref. https://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sn gt
nnoremap sp gT
nnoremap st :<C-u>tabnew<CR>
nnoremap ss :<C-u>split<CR>
nnoremap sv :<C-u>vsplit<CR>


"
" command
"
" 終了コマンドをエイリアス
:command Q q

" wもよく大文字にしちゃうので
:command W w
:command Wq wq


"
" NeoBundle
"
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
  NeoBundle 'jistr/vim-nerdtree-tabs'
  NeoBundle "slim-template/vim-slim"
  NeoBundle "digitaltoad/vim-pug"
  NeoBundle 'posva/vim-vue'
  NeoBundle 'ConradIrwin/vim-bracketed-paste'
  NeoBundle 'mattn/emmet-vim'
  NeoBundle 'alvan/vim-closetag'
  NeoBundle 'elixir-editors/vim-elixir'
  if filereadable(expand('~/.wakatime.cfg'))
    NeoBundle 'wakatime/vim-wakatime'
  endif

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
  " nnoremap <silent><C-e> :NERDTreeToggle<CR>
  " nnoremap <silent><C-w> :NERDTreeToggle<CR>
  " map <C-n> :NERDTreeToggle<CR>
  " nnoremap nd :NERDTreeToggle<CR>
  nnoremap nd :NERDTreeTabsToggle<CR>
endif

"
" dein
"
if isdirectory(expand('~/.cache/dein'))
  "dein Scripts-----------------------------
  if &compatible
    set nocompatible               " Be iMproved
  endif
  
  " Required:
  set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
  
  " Required:
  if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')
  
    " Let dein manage dein
    " Required:
    call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  
    " Add or remove your plugins here like this:
    "call dein#add('Shougo/neosnippet.vim')
    "call dein#add('Shougo/neosnippet-snippets')
    " call dein#add('tpope/vim-fugitive')
    " call dein#add('ctrlpvim/ctrlp.vim')
    call dein#add('scrooloose/nerdtree')
    call dein#add('jistr/vim-nerdtree-tabs')
    call dein#add('slim-template/vim-slim')
    call dein#add('digitaltoad/vim-pug')
    call dein#add('posva/vim-vue')
    call dein#add('ConradIrwin/vim-bracketed-paste')
    call dein#add('mattn/emmet-vim')
    call dein#add('alvan/vim-closetag')
    call dein#add('elixir-editors/vim-elixir')
    if filereadable(expand('~/.wakatime.cfg'))
      call dein#add('wakatime/vim-wakatime')
    endif
    " color scheme
    " call dein#add('w0ng/vim-hybrid')
    " call dein#add('nanotech/jellybeans.vim')
    " call dein#add('tomasr/molokai')
    " call dein#add('sjl/badwolf')
    call dein#add('morhetz/gruvbox')


    " Required:
    call dein#end()
    call dein#save_state()
  endif
  
  " Required:
  filetype plugin indent on
  syntax enable
  
  " If you want to install not installed plugins on startup.
  if dein#check_install()
    call dein#install()
  endif
  
  "End dein Scripts-------------------------


  " Depending on dein

  " color scheme
  autocmd ColorScheme * highlight Normal ctermbg=none
  colorscheme gruvbox
  
  " 隠しファイルをデフォルトで表示させる
  let NERDTreeShowHidden = 1
  
  " デフォルトでツリーを表示させる
  "autocmd VimEnter * execute 'NERDTree'

  " Ctrl+eでNERDTreeをトグル
  " nnoremap <silent><C-e> :NERDTreeToggle<CR>
  " nnoremap <silent><C-w> :NERDTreeToggle<CR>
  " map <C-n> :NERDTreeToggle<CR>
  " nnoremap nd :NERDTreeToggle<CR>
  nnoremap nd :NERDTreeTabsToggle<CR>
endif
