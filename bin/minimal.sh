#!/bin/sh


# bash_profile
cat <<EOF >> ~/.bash_profile

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

export LESS="-iMRS"
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
EOF


# bashrc
cat <<EOF >> ~/.bashrc

export HISTSIZE=10000
export HISTCONTROL=ignoredups

alias l='ls -lah --time-style=long-iso'
alias ll='ls -lh --time-style=long-iso'
alias la='ls -a'
EOF


# gitconfig
cat <<EOF >> ~/.gitconfig

[alias]
	ad = add
	ada = add --all
	st = status
	co = checkout
	br = branch
	bra = branch -a
	cm = commit
	cmm = commit -m
	cmam = commit --amend
	mg = merge
	mg-noff = merge --no-ff
	ft = fetch
	fet = fetch
	pll = pull
	psh = push
	diff-no = diff --name-only
	log-graph = log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
EOF


# vimrc
cat <<EOF >> ~/.vimrc

set number
set expandtab
set tabstop=2
set shiftwidth=2
set smartcase
set smartindent

inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-j> <C-g>j
inoremap <C-k> <C-g>k
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>l
inoremap <C-d> <C-o>x

:command Q q
:command W w
:command Wq wq
EOF
