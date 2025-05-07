#! /bin/bash

# Create S3 bucket
aws s3api create-bucket --bucket mundose-terraform-state-2025 --region us-east-1

# Create DynamoDB table
aws dynamodb create-table \
    --table-name terraformstatelock \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5