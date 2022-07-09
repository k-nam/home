set -e
DEST_PATH=~/.trash/$(date +%Y-%m-%d-%H-%M-%S)
mkdir -p $DEST_PATH

for file in "$@"
do
    mv "$file" $DEST_PATH
done