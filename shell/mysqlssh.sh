set -x

# ex) flicspy-prod-tmdb.cluster-cwgzu6uedrc3.us-east-2.rds.amazonaws.com
DB_HOST=$1

# ex) ubuntu@3.133.160.204
JUMP=$2
ssh -N -L 3307:$DB_HOST:3306 ubuntu@$JUMP