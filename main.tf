
#EC2
resource "aws_instance" "ec2Instance" {
  provider      = aws.ap-south-1
  depends_on    = [aws_vpc.dev-vpc]
  ami           = "ami-0d63de463e6604d0a"
  instance_type = "t2.micro"
  subnet_id     = ["subnet-06ce87a16f747f295", "subnet-0d4eae7125270e8ae"]
  
  tags = {
    Name = "my first instance created through terraform"
  }
}

#VPC

resource "aws_vpc" "dev-vpc" {
  cidr_block         = "10.0.0.0/16"
  instance_tenancy   = "default"

  tags = {
  Name = "dev-vpc"
  }
  }

  #SG

  
  resource "aws_security_group" "dev-sg" {
  name        = "dev-sg"
  description = "Allows all inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.dev-vpc.id

  tags = {
    Name = "dev-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.dev-vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = aws_vpc.main.ipv6_cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
