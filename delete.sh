#!/bin/bash
set -euo pipefail

KEY_NAME="testserver-key"
STACK_NAME="testserver"
KEY_FILE="${KEY_NAME}.pem"

aws cloudformation delete-stack \
    --stack-name "$STACK_NAME"

aws cloudformation wait stack-delete-complete \
    --stack-name "$STACK_NAME"

# AWS側のキーペアを削除
if aws ec2 describe-key-pairs \
    --key-names "$KEY_NAME" \
    >/dev/null 2>&1
then
    echo "AWS側のキーペアを削除します: $KEY_NAME"

    aws ec2 delete-key-pair \
        --key-name "$KEY_NAME"
fi

# ローカルの秘密鍵を削除
if [ -f "$KEY_FILE" ]; then
    echo "ローカルの秘密鍵を削除します: $KEY_FILE"
    rm -- "$KEY_FILE"
fi

echo "テスト環境の削除が完了しました"