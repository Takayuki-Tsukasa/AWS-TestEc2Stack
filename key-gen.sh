#!/bin/bash
set -euo pipefail
KEY_NAME="testserver-key"

echo "=== Create Key Pair ==="

aws ec2 create-key-pair \
  --key-name "$KEY_NAME" \
  --query "KeyMaterial" \
  --output text > "${KEY_NAME}.pem"

chmod 400 "${KEY_NAME}.pem"

echo
echo "========================================"
echo "Download:"
echo
echo "CloudShell"
echo "↓"
echo "Actions"
echo "↓"
echo "Download file"
echo "↓"
echo "/home/cloudshell-user/test-ec2/${KEY_NAME}.pem"
echo "========================================"

echo
echo "After downloading, run:"
echo
echo "./deploy.sh"