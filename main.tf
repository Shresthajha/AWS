

#S3 
resource "aws_s3_bucket" "dev-bucket" {
  bucket = "sdev-sbucket"
 
  tags = {
     Name        = "sdev-sbucket"
     Environment = "dev"
   }
}


#EC2
resource "aws_instance" "dev-instance" {
 
  depends_on    = [aws_vpc.dev-vpc]
  ami           = "ami-0d63de463e6604d0a"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.dev-subnet.id
  vpc_security_group_ids = [aws_security_group.dev-sg.id]
  key_name = "shrestha"
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


#SUBNET

resource "aws_subnet" "dev-subnet" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "dev-subnet"
  }
}


  #SG

  resource "aws_security_group" "dev-sg" {
  name        = "dev-sg"
  description = "security group for allowing all inbound and outbound traffic"
  vpc_id      = aws_vpc.dev-vpc.id

#inbound -> allow all
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

#outbound -> allow all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

 
