set -eux
VERSION=$1
NETOWRK=$2
ENV=$3
if [ $ENV == 'dev' ]
then
PROJECT=rls-blt-dev-garuda
elif [ $ENV == 'stg' ]
then
PROJECT=r-garuda-stg
else
PROJECT=r-garuda-prd
fi

gcloud container clusters get-credentials cuisine-$VERSION-$NETOWRK-$ENV --region asia-northeast1 --project $PROJECT