provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "ap-south-1"
  region = "ap-south-1"
}

