resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.provpc.id

  tags = {
    Name = "proig"
  }
}

output "igoutput" {
  value = aws_internet_gateway.gw.id
}