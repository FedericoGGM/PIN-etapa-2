#! /bin/bash


echo "Checking S3 bucket..."
aws s3 ls s3://mundose-terraform-state-2025
echo -e "\nChecking DynamoDB table..."
aws dynamodb describe-table --table-name terraformstatelock
echo -e "\nChecking AWS identity..."
aws sts get-caller-identity