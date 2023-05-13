set -eux
# Create a folder
DIR=$1
TOKEN=$2
ORG=$3
mkdir -p $DIR && cd $DIR
curl -o actions-runner-linux-x64-2.288.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.288.1/actions-runner-linux-x64-2.288.1.tar.gz
echo "325b89bdc1c67264ec6f4515afda4534f14a6477d9ba241da19c43f9bed2f5a6  actions-runner-linux-x64-2.288.1.tar.gz" | shasum -a 256 -c
tar xzf ./actions-runner-linux-x64-2.288.1.tar.gz
# Create the runner and start the configuration experience
./config.sh --url https://github.com/$ORG --token $TOKEN
sudo ./svc.sh install
sudo ./svc.sh start
rm *.gz