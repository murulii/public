resource "aws_security_group" "prosg" {
  name        = "prosg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.provpc.id

  tags = {
    Name = "prosg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.prosg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "apache" {
  security_group_id = aws_security_group.prosg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.prosg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

output "sg" {
  value = aws_security_group.prosg.id
}