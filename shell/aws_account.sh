export AWS_ACCESS_KEY_ID=
if [ "$#" -eq 1 ]; then
  export AWS_PROFILE=$1
fi
echo "Current AWS user: $(aws sts get-caller-identity)"
