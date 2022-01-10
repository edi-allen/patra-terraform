terraform {
  backend "s3" {
    bucket = "ediallen-patra-terraform-state"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "ediallen-patra-terraform-locks"
    encrypt = true
  }
}
