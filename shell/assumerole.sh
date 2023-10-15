set -u

PROFILE=$1
ROLE_ARN=$2
OUT=$(aws sts assume-role --role-arn $ROLE_ARN --role-session-name script-session --duration-seconds 900 --profile $PROFILE)
echo $OUT
export AWS_ACCESS_KEY_ID=$(echo $OUT | jq -r '.Credentials''.AccessKeyId');\
export AWS_SECRET_ACCESS_KEY=$(echo $OUT | jq -r '.Credentials''.SecretAccessKey');\
export AWS_SESSION_TOKEN=$(echo $OUT | jq -r '.Credentials''.SessionToken');

