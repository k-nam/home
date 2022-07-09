export AWS_PROFILE=dev
aws sts get-caller-identity
aws ec2 stop-instances --instance-ids i-09d12df0fbfe4667a --region us-east-2