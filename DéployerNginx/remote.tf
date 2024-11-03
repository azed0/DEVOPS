terraform {
  backend "s3" {
    access_key = "**"
    secret_key = "**"
    region = "us-east-1"
    bucket = "azed01-tfstate"
    key = "terraform.tfstate"
  }
}