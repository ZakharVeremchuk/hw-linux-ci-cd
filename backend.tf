terraform {
  backend "s3" {
    bucket       = "zakhar-state-bucket"
    key          = "terraform.tfstate"
    region       = "us-west-2"
    encrypt      = true
    use_lockfile = true
  }
}

