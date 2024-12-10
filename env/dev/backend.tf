terraform {
  backend "s3" {
    bucket         = "dev-terraform-state-bucket"
    key            = "demo_infra/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "dev-terraform-state-lock-dynamodb-table"
  }
}
