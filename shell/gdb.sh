set -eux

git checkout master
git branch -D $1
git push --delete origin $1