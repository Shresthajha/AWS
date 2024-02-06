
#EC2
resource "aws_instance" "ec2Instance" {
 
  depends_on    = [aws_vpc.dev-vpc]
  ami           = "ami-0d63de463e6604d0a"
  instance_type = "t2.micro"
  subnet_id     = "subnet-06ce87a16f747f295"
  vpc_security_group_ids = [aws_security_group.dev-sg.id]
  
  tags = {
    Name = "first instance via terraform"
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
  description = "security group for allowing all inbound and outbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

 
