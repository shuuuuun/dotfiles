MITAMAE_VERSION := 1.14.0

.PHONY: setup
setup: prepare
	curl -L -o /usr/local/bin/mitamae https://github.com/itamae-kitchen/mitamae/releases/download/v${MITAMAE_VERSION}/mitamae-x86_64-linux
	chmod +x /usr/local/bin/mitamae
	mitamae version

.PHONY: run
run:
	mitamae local --plugins=./plugins lib/recipe.rb

.PHONY: rsync
rsync:
	rsync -ahvc --append-verify . ${REMOTE_HOST}:~/mitamae

prepare:
	git submodule update --init --recursive
