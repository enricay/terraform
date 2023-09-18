terraform {
  backend "s3" {
    bucket = "terra-dynadb-sample-bucket"
    key = "workspaces-example/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "terra-dynadb-sample-bucket-table"
    encrypt = true
    
  }
}