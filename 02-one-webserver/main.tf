# This is a Bash script that writes the text “Hello, World” into index.html and 
# runs a tool called busybox (which is installed by default on Ubuntu) to fire 
# up a web server on port 8080 to serve that file.

# The reason this example uses port 8080, rather than the default HTTP port 80, is that listening on any port less than 1024 requires root user privileges. 
# This is a security risk, because any attacker who manages to compromise your server would get root privileges, too.


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
  ami                    = "ami-0fb653ca2d3203ac1"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  user_data              = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "InstancewithSG"
  }
}


resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


# This code creates a new resource called (notice how all resources for the AWS provider begin with ) 
# and specifies that this group allows incoming TCP requests on port 8080 from the CIDR block 0.0.0.0/0.
#  CIDR blocks are a concise way to specify IP address ranges. For example, a CIDR block of 10.0.0.0/24 
#  represents all IP addresses between 10.0.0.0 and 10.0.0.255. The CIDR block 0.0.0.0/0 is an IP address 
#  range that includes all possible IP addresses, so this security group allows incoming requests on port 8080 from any IP.

# To pass the SG ID to the EC2 Instance, we use terraform expression.

# An expression in Terraform is anything that returns a value. 
# You’ve already seen the simplest type of expressions, literals, such as strings (e.g.ami-0fb653ca2d3203ac1
# One particularly useful type of expression is a REFERENCE, which allows you to access values from other parts of your code. ,


# To access the ID of the security group resource you are going to need to use a resource attribute reference, 
# which uses the following syntax:

#     provider_type.name.attribute

# Attribute is one of the arguments of a resource or attribute exported by the resource
# The security group exports an attribute called , so the expression to reference it will look like this


# When you add a reference from one resource to another, you create an implicit dependency. Terraform parses these dependencies,
# builds a dependency graph from them, and uses that to automatically determine in which order it should create resources.

# You can even get Terraform to show you the dependency graph by running the command:

# terraform graph