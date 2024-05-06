set -eux

LOCATION=tokyo
# LOCATION=us-multi

truncate -s 1G temp.txt
gcloud storage cp temp.txt gs://test-$LOCATION/temp.txt
gcloud storage cp gs://test-$LOCATION/temp.txt ./temp2.txt

rm -rf temp.txt temp2.txt