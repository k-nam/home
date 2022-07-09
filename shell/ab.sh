if [ $1 == "f-admin" ]
then
AC=461691961615
elif [ $1 == "f-dev" ]
then
AC=
elif [ $1 == "flicspy-prod" ]
then
AC=
fi

OUT=$(aws sts assume-role --role-arn arn:aws:iam::${AC}:role/k-nam --role-session-name temp);\
export AWS_ACCESS_KEY_ID=$(echo $OUT | jq -r '.Credentials''.AccessKeyId');\
export AWS_SECRET_ACCESS_KEY=$(echo $OUT | jq -r '.Credentials''.SecretAccessKey');\
export AWS_SESSION_TOKEN=$(echo $OUT | jq -r '.Credentials''.SessionToken');