set -eux

git checkout master
git pull
git fetch --prune
git branch -D "$1"
