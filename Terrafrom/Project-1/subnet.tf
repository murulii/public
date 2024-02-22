resource "aws_subnet" "prosubnet" {
    vpc_id = aws_vpc.provpc.id
    cidr_block = "192.168.1.0/24"
  
  tags = {
    Name = "ProSubnet"
  }
}

output "subnetoutput" {

    value = aws_subnet.prosubnet.id
  
}