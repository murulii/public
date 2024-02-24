provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}

//Creating Instance
resource "aws_instance" "ec2" {

  ami = var.aws_ami
  instance_type = var.aws_instance_type
  tags = {
    Name = "Production"
  }
}

