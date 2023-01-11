CLUSTER=$1
PROJECT=$2
ZONE=$3
gcloud container clusters get-credentials $CLUSTER --project f-sandbox --zone $ZONE