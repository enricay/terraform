terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
}
# PROVIDER 

# In provied  section, we tell terraform which provider to use eg AWS, Docker, Azure etc
# The region [us-east-2] where you want to deploy the resources and the AZ like us-east-2a, us-east-2b

# RESOURCES

# For each type of provider, there are many different kinds of resources that you can create, such as servers, databases, and load balancers.
# resource "provider_type" "name"{
#     [config..] with arguments that are specific to the resources we are creating
#     key = value pair arguments
# }

# TAGS
# We can add tags to the resources to add more metadata

# GITIGNORE

# .terraform 
# *.tfstate
# *.tfstate.backup