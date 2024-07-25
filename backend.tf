terraform {
  backend "s3" {
    bucket         = "terraform-tfstate-cloud-tech"
    key            = "state/terraform-management-state.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "surgemail-terraform-backend"
  }
}