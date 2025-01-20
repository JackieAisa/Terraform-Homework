provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "key" {
  key_name   = "bastion-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Canonical
}

resource "aws_instance" "web" {

   ami = data.aws_ami.amazon_linux_2.id
   instance_type = "t2.micro"
   availability_zone = "us-east-1a"  # if more then one subnet in an AZ then subnet_id = "subnet-0007ec70aa8145f82"
   key_name = aws_key_pair.key.key_name
   vpc_security_group_ids = [aws_security_group.allow_tls.id]
   user_data = file("apache.sh")

   tags = {
    Name = "web-1"
  }
}

resource "aws_instance" "web2" {

   ami = data.aws_ami.amazon_linux_2.id
   instance_type = "t2.micro"
   availability_zone = "us-east-1b"
   key_name = aws_key_pair.key.key_name
   vpc_security_group_ids = [aws_security_group.allow_tls.id]
   user_data = file("apache.sh")

   tags = {
    Name = "web-2"
  }
}

resource "aws_instance" "web3" {

   ami = data.aws_ami.amazon_linux_2.id
   instance_type = "t2.micro"
   availability_zone = "us-east-1c"
   key_name = aws_key_pair.key.key_name
   vpc_security_group_ids = [aws_security_group.allow_tls.id]
   user_data = file("apache.sh")

   tags = {
    Name = "web-3"
  }
}

