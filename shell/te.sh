set -eux

export AWS_PROFILE=terraform-f-dev
ROLE_ARN=arn:aws:iam::721756646069:role/terraform
if [ $1 == "prod" ]
then
export AWS_PROFILE=terraform-flicspy-prod
ROLE_ARN=arn:aws:iam::758533789927:role/terraform
fi

bash -c "rm -rf .terraform"
terraform init -upgrade -backend-config=bucket=flicspy-$1-terraform -var="env=$1" -var="role_arn=$ROLE_ARN"

if [ $2 == "apply" ]
then
terraform apply -var="env=$1" -var="role_arn=$ROLE_ARN"
else
shift
terraform $@
fi