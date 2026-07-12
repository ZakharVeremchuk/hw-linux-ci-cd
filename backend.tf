terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

# Після створення S3-бакета розкоментуй S3 і закоментуй local вище:
# terraform {
#   backend "s3" {
#     bucket       = "zakhar-state-bucket"
#     key          = "terraform.tfstate"
#     region       = "us-west-2"
#     encrypt      = true
#     use_lockfile = true
#   }
# }
