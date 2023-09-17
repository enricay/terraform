output "name" {
  value       = aws_instance.example.public_ip
  description = "The Public IP address of the web server"
}


# This code uses an attribute reference again, this time referencing the public_ip attribute of the resource. If you run the
# command again, Terraform will not apply any changes (because you haven’t changed any resources), but it will show you the new output at the very end: