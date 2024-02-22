resource "aws_vpc" "provpc" {
  cidr_block = "192.168.1.0/24"
  tags = {
    Name = "ProVpc"
  }
}

output "vpcid" {
    value = aws_vpc.provpc.id
  
}