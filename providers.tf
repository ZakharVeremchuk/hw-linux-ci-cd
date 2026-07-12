provider "aws" {
  region = "us-east-1"
}

# S3 state-бакет історично в us-west-2
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}
