set -eu

OUT=$(aws sts get-session-token --token-code $1 --serial-number arn:aws:iam::461691961615:mfa/k-nam --profile k-nam --duration-seconds 43200)
export AWS_ACCESS_KEY_ID=$(echo $OUT | jq -r '.Credentials''.AccessKeyId');\
export AWS_SECRET_ACCESS_KEY=$(echo $OUT | jq -r '.Credentials''.SecretAccessKey');\
export AWS_SESSION_TOKEN=$(echo $OUT | jq -r '.Credentials''.SessionToken');

# echo $AWS_ACCESS_KEY_ID
# echo $AWS_SECRET_ACCESS_KEY
# echo $AWS_SESSION_TOKEN

aws configure set profile.mfa.aws_access_key_id "$AWS_ACCESS_KEY_ID"
aws configure set profile.mfa.aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
aws configure set profile.mfa.aws_session_token "$AWS_SESSION_TOKEN"