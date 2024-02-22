module "aws_ec2" {

    source = "./modules/aws_ec2"

    aws_ami = var.aws_ami
    instance_type = var.instance_type
  
}