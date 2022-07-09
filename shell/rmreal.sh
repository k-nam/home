set -x

for file in "$@"
do
    rm -rf "$file"
done