# terraform {
#   backend "s3" {
#     bucket = "terra-dynadb-sample-bucket"
#     key = "global/s3/terraform.tfstat"
#     region = "us-east-2"
#     dynamodb_table = "terra-dynadb-sample-bucket-table"
#     encrypt = true
    
#   }
# }