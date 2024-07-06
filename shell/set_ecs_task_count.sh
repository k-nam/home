set -eux

COUNT=$1

# aws ecs update-service --cluster f-admin-github-actions-runner --service flicspy-c7g-medium --desired-count $COUNT --region ap-south-2 --profile f-admin > /dev/null &

aws ecs update-service --cluster flicspy-stg-1-ms-activity --service flicspy-stg-1-ms-activity-main --desired-count $COUNT --region ap-northeast-2 --profile f-dev > /dev/null &
aws ecs update-service --cluster flicspy-stg-1-ms-content --service flicspy-stg-1-ms-content-main --desired-count $COUNT --region ap-northeast-2 --profile f-dev > /dev/null &
aws ecs update-service --cluster flicspy-stg-1-ms-user --service flicspy-stg-1-ms-user-main --desired-count $COUNT --region ap-northeast-2 --profile f-dev > /dev/null &

aws ecs update-service --cluster flicspy-prd-ms-activity --service flicspy-prd-ms-activity-main --desired-count $COUNT --region ap-northeast-2 --profile flicspy-prd > /dev/null &
aws ecs update-service --cluster flicspy-prd-ms-content --service flicspy-prd-ms-content-main --desired-count $COUNT --region ap-northeast-2 --profile flicspy-prd > /dev/null &
aws ecs update-service --cluster flicspy-prd-ms-user --service flicspy-prd-ms-user-main --desired-count $COUNT --region ap-northeast-2 --profile flicspy-prd > /dev/null &



