terraform {
  backend "s3" {
    bucket         = "secure-saas-terraform-state-747747309806"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "secure-saas-terraform-locks"
    encrypt        = true
  }
}
