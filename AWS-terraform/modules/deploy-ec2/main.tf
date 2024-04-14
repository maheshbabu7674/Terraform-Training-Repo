terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "<=5.45.0"
    }
  }
}



resource "aws_instance" "example" {
  ami           = "ami-051f8a213df8bc089" # Specify an appropriate AMI ID
  instance_type =  var.instance_type

  tags = {
    Name = "Terraform-Training"
  }
}
