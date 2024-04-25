set -eux

CUR_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ $CUR_BRANCH == "master" ]; then
    echo "Currently on master, abort"
    exit 1
fi

git checkout master
git pull

if [[ $(git diff $CUR_BRANCH) ]]; then
  echo "ERROR (There was some un-pushed commit in local branch)"
  exit 1
fi

git fetch --prune
git branch -D $CUR_BRANCH
echo "OK"