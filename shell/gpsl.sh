set -eux

CUR_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ $CUR_BRANCH == "master" ]; then
    echo "Currently on master, abort"
    exit 1
fi

git checkout master
git pull
git fetch --prune
git branch -D $CUR_BRANCH
git push --delete origin $CUR_BRANCH