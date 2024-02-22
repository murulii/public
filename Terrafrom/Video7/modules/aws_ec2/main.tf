provider "aws" {
  region = "ap-southeast-1"
  secret_key = "Xuvgn54qIQOlpju0CoRXPz3LkBWsR4y1V7OE77jR"
  access_key = "AKIA2T2S2H2K7LV66YXL"
}

resource "aws_instance" "ec2" {
  ami = var.aws_ami
  instance_type = var.instance_type

  tags = {
    Name = "Webserver"
  }
}