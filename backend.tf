terraform {
  backend "s3" {
    bucket         = "kaveditrailbucket"
    key            = "file/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "lockstate"
  }
}
