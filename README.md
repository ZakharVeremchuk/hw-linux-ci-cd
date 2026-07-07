# Terraform Project

This project creates a simple AWS infrastructure with Terraform.

## Project structure
- main.tf — entry point that connects all modules.
- backend.tf — local backend configuration for Terraform state.
- modules/s3-backend — creates the S3 bucket and DynamoDB table for Terraform state.
- modules/vpc — creates the VPC and subnets.
- modules/ecr — creates the ECR repository.

## Commands
Run these commands from the project root:

```bash
terraform init -backend=false
terraform init -reconfigure
terraform plan
terraform apply
terraform destroy
```

## Modules
- s3-backend: creates the S3 bucket and DynamoDB table used for Terraform state.
- vpc: creates a VPC with public and private subnets.
- ecr: creates an ECR repository with image scanning enabled.

aws eks --region us-east-1 update-kubeconfig --name eks-cluster-demo