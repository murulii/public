provider "aws" {
  region = "ap-southeast-1"
  secret_key = ""
  access_key = ""
}

resource "aws_instance" "ec2" {
  ami = var.aws_ami
  instance_type = var.instance_type

  tags = {
    Name = "Webserver"
  }
}
