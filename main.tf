provider "aws" {
region = "us-east-2"
}

data "aws_vpc" "default" {
  default = true
}
resource "aws_security_group" "web" {
  vpc_id      = data.aws_vpc.default.id
  name        = "web-sg"
  description = "Allow HTTP and SSH traffic"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "web" {
  ami                         = "ami-024ebc7de0fc64e44"
  instance_type               = "t2.small"
  key_name                    = "haiii"
  user_data                   = file("userdata.sh")
  vpc_security_group_ids      = [aws_security_group.web.id]
  tags = {
    Name = "WordPressServer"
  }
}

output "security_group_id" {
  value = aws_security_group.web.id
}
