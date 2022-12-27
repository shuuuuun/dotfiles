.PHONY: setup
setup: prepare
	bin/setup
	bin/mitamae version

.PHONY: run
run:
	bin/mitamae local --plugins=./plugins lib/recipe.rb

.PHONY: rsync
rsync:
	rsync -ahvc --append-verify . ${REMOTE_HOST}:~/mitamae

prepare:
	git submodule update --init --recursive
