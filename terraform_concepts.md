# Terraform Project Documentation

## Table of Contents
1. [Project Files Overview](#project-files-overview)
   - [main.tf](#1-main-tf)
   - [setup.tf](#2-setup-tf)
   - [backend.tf](#3-backend-tf)
2. [GitHub Actions Integration](#github-actions-integration)
   - [Workflow Overview](#workflow-overview)
   - [Terraform Commands](#terraform-commands)
3. [Deployment Guide](#deployment-guide)
   - [Prerequisites](#prerequisites)
   - [Setup Steps](#setup-steps)
4. [Verification and Testing](#verification-and-testing)
   - [Workflow Verification](#workflow-verification)
   - [AWS Resource Verification](#aws-resource-verification)
   - [Web Server Testing](#web-server-testing)

## Project Files Overview

### 1. `main.tf`

**Purpose:**  
Defines the main infrastructure resources for your AWS environment, specifically the EC2 instance (webserver).

**Key Components:**
- **`aws_instance` resource:**  
  - Launches an EC2 instance using the specified AMI (`ami-00c39f71452c08778`)
  - Sets the instance type to `t2.micro`
  - Associates a public IP address
  - Attaches a security group (`aws_security_group.sg`)
  - Places the instance in a subnet (`aws_subnet.subnet`)
  - Uses a user data script (`create_apache.sh`) to bootstrap the instance

### 2. `setup.tf`

**Purpose:**  
Sets up the foundational AWS resources required for your infrastructure.

**Key Components:**
- **`aws_vpc` resource:**  
  - Creates a VPC with CIDR block `10.0.0.0/16`
  - Enables DNS support and hostnames

- **`aws_internet_gateway` resource:**  
  - Attaches an Internet Gateway to the VPC

- **`aws_default_route_table` resource:**  
  - Routes traffic (`0.0.0.0/0`) through the Internet Gateway

- **`aws_subnet` resource:**  
  - Creates a subnet in the first available AZ
  - Assigns CIDR block `10.0.1.0/24`

- **`aws_security_group` resource:**  
  - Allows inbound traffic on ports 22 (SSH) and 80 (HTTP)
  - Allows all outbound traffic

### 3. `backend.tf`

**Purpose:**  
Configures the backend for Terraform state management.

**Key Components:**
- **`terraform` block with `backend "s3"`:**  
  - Stores state file in S3 bucket `mundose22`
  - Sets region to `us-east-1`
  - Uses DynamoDB table `terraformstatelock` for state locking

## GitHub Actions Integration

### Workflow Overview

The GitHub Actions workflow automates the deployment process when changes are pushed to the repository.

**Key Steps:**
1. Checkout code
2. Set up Terraform
3. Configure AWS credentials
4. Run Terraform commands

### Terraform Commands

The workflow executes these commands in sequence:
- `terraform init`: Initializes the working directory
- `terraform fmt -check`: Checks code formatting
- `terraform validate`: Validates configuration
- `terraform plan`: Generates execution plan
- `terraform apply -auto-approve`: Applies changes

## Deployment Guide

### Prerequisites

- AWS Account with necessary permissions
- Terraform Cloud/State Backend (optional)
- GitHub Repository
- AWS Credentials

### Setup Steps

1. **Store AWS Credentials in GitHub Secrets**
   - Add `AWS_ACCESS_KEY_ID`
   - Add `AWS_SECRET_ACCESS_KEY`
   - Add `AWS_DEFAULT_REGION` (optional)

2. **Add Terraform Files to Repository**
   - `main.tf`
   - `setup.tf`
   - `backend.tf`
   - `create_apache.sh`

3. **Create GitHub Actions Workflow**
   - Create `.github/workflows/terraform.yml`
   - Configure workflow triggers and steps

## Verification and Testing

### Workflow Verification

1. **Check GitHub Actions Logs**
   - Review workflow execution steps
   - Verify successful completion
   - Check for errors or warnings

### AWS Resource Verification

1. **EC2 Instances**
   - Verify instance is running
   - Check instance tags
   - Confirm public IP assignment

2. **VPC and Networking**
   - Verify VPC creation
   - Check subnet configuration
   - Confirm security group rules
   - Validate Internet Gateway attachment

### Web Server Testing

1. **HTTP Access**
   - Test web server accessibility
   - Verify Apache default page

2. **SSH Access**
   - Connect to instance
   - Check Apache service status
   - Verify system configuration

## Best Practices

1. **Security**
   - Never hardcode secrets
   - Use least-privilege AWS credentials
   - Implement proper IAM roles

2. **State Management**
   - Use remote state storage
   - Implement state locking
   - Regular state backups

3. **Code Organization**
   - Separate configuration files
   - Use variables for flexibility
   - Document all resources

