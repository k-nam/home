set -x
sudo kill -9 $(sudo lsof -t -i:$1 -sTCP:LISTEN)