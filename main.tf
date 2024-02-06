
#EC2
resource "aws_instance" "ec2Instance" {
 
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

  
 
