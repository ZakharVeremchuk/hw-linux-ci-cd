# Створюємо S3-бакет
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name
  region = "us-west-2"

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "lesson-5"
  }
}

# Налаштовуємо версіонування для S3-бакета
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  region = "us-west-2"

  versioning_configuration {
    status = "Enabled"
  }
}

# Встановлюємо контроль власності для S3-бакета
resource "aws_s3_bucket_ownership_controls" "terraform_state_ownership" {
  bucket = aws_s3_bucket.terraform_state.id
  region = "us-west-2"
  
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

