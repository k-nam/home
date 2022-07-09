git checkout -b $1
git commit --allow-empty -m "$1"
git push --set-upstream origin $1