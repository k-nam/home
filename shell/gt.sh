set -x
git add -A
git commit --allow-empty -m "try $1"
git push
