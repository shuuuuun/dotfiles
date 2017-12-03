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


" 終了コマンドをエイリアス
:command Q q

" wもよく大文字にしちゃうので
:command W w
:command Wq wq


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
