terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "<=5.45.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAVRUVP3F4MYRKRVPJ"
  secret_key = "0o5GDeFIufZBOsudFBJ0YnhZn+qcCf0UaCKS3exk"
}

resource "aws_instance" "example" {
  ami           = "ami-051f8a213df8bc089" # Specify an appropriate AMI ID
  instance_type =  var.instance_type

  tags = {
    Name = "Terraform-Training"
  }
}