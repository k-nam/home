set -eu

credentials=$(aws sts get-session-token --token-code $1 --serial-number arn:aws:iam::461691961615:mfa/k-nam --profile k-nam --duration-seconds 129600  \
--query "Credentials.[AccessKeyId,SecretAccessKey,SessionToken]" --output text)

id=$(echo $credentials | cut -d ' ' -f 1)
key=$(echo $credentials | cut -d ' ' -f 2)
token=$(echo $credentials | cut -d ' ' -f 3)

aws configure set profile.mfa.aws_access_key_id "$id"
aws configure set profile.mfa.aws_secret_access_key "$key"
aws configure set profile.mfa.aws_session_token "$token"