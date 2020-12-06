.PHONY: run
run:
	mitamae local --plugins=./plugins lib/recipe.rb

.PHONY: rsync
rsync:
	rsync -ahvc --append-verify . ${REMOTE_HOST}:~/mitamae
