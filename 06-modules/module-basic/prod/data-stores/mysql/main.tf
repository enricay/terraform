terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {

    # This backend configuration is filled in automatically at test time by Terratest. If you wish to run this example
    # manually, uncomment and fill in the config below.

    bucket         = "terra-dynadb-sample-bucket"
    key            = "stage/data-stores/mysql.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terra-dynadb-sample-bucket-table"
    encrypt        = true

  }
}

provider "aws" {
  region = "us-east-2"
}

# resource "aws_db_instance" "example" {
#   identifier_prefix   = "terraform-up-and-running"
#   engine              = "mysql"
#   allocated_storage   = 10
#   instance_class      = "db.t2.micro"
#   skip_final_snapshot = true

#   db_name             = var.db_name

#   username = var.db_username
#   password = var.db_password
# }

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  allocated_storage   = 10
  db_name             = "mydb"
  engine              = "mysql"
  instance_class      = "db.t2.micro"
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
}
# Nother way to store password or other sensitive data is to store in AWS secret manager, KMS etc.

# You could use the AWS Secrets Manager UI to store the secret and then read the secret back out in your Terraform code using the aws_secretsmanager_secret_version
# data source:


# password would now be 
#  password = data.aws_secretsmanager_secret_version.db_password.secrets_string


# The second option for handling secrets is to manage them completely outside of Terraform (e.g., in a password manager such as 1Password, LastPass, or OS X Keychain) and to pass the secret into Terraform via an environment variable. 

# variable "db_password{
#   description = "The password for DB"
#   type = string
# }"

# Note that this variable does not have a . This is intentional. You should not store your database password or any sensitive information in plain text. Instead, you’ll set this variable using an environment variable.