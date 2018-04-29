#!/bin/sh

cat <<EOF >> ~/.bash_profile

export LESS="-iMRS"
EOF

cat <<EOF >> ~/.bashrc

export HISTSIZE=10000
export HISTCONTROL=ignoredups

alias l='ls -lah --time-style=long-iso'
alias ll='ls -lh --time-style=long-iso'
alias la='ls -a'

alias be='bundle exec'

alias psgrep='ps aux | grep -v grep | grep'
alias psag='ps aux | ag -v ag | ag'
EOF

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

cat <<EOF >> ~/.vimrc

:command Q q
:command W w
:command Wq wq
EOF
