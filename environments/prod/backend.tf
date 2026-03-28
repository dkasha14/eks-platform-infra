terraform {
  backend "s3" {
    bucket         = "asha-eks-cluster-tf-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "asha-eks-terraform-locks"
    encrypt        = true
  }
}
