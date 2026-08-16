#!/bin/bash
set -euo pipefail

KEY_NAME="testserver-key"
STACK_NAME="testserver"
MYIP="$(curl https://checkip.amazonaws.com)/32"

if [ ! -f "${KEY_NAME}.pem" ]; then
    if aws ec2 describe-key-pairs \
        --key-names "$KEY_NAME" \
        > /dev/null 2>&1
    then
        echo "AWS側に残っているキーペアを削除します: $KEY_NAME"

        aws ec2 delete-key-pair \
            --key-name "$KEY_NAME"
    fi

    echo "キーペアを新しく作成します"
    ./key-gen.sh
fi

# CloudFormationデプロイ
aws cloudformation deploy \
    --template-file template.yaml \
    --stack-name "$STACK_NAME" \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides \
        KeyName="$KEY_NAME" \
        AllowIpAdr="$MYIP"
# IPアドレス表示
aws cloudformation describe-stacks \
    --stack-name "$STACK_NAME" \
    --query "Stacks[0].Outputs[?OutputKey=='PublicIpAddress'].OutputValue" \
    --output text