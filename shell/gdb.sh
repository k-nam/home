set -eux

git branch -D $1
git push --delete origin $1