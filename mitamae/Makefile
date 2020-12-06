MITAMAE_VERSION := 1.11.7

.PHONY: setup
setup:
	curl -L -o /usr/local/bin/mitamae https://github.com/itamae-kitchen/mitamae/releases/download/v${MITAMAE_VERSION}/mitamae-x86_64-linux
	chmod +x /usr/local/bin/mitamae
	mitamae version

.PHONY: run
run:
	mitamae local --plugins=./plugins lib/recipe.rb

.PHONY: rsync
rsync:
	rsync -ahvc --append-verify . ${REMOTE_HOST}:~/mitamae
