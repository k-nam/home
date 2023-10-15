set -eux

CUR_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ $CUR_BRANCH == "master" ]; then
    echo "Currently on master, abort"
    exit 1
fi

git checkout master
git pull
git diff $CUR_BRANCH --exit-code --quiet
git fetch --prune
git branch -D $CUR_BRANCH
