provider "aws" {
    region = "us-east-1"
    access_key = "AKIA2HGKR75RY2T7DDJD"
    secret_key = "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"
}

resource "aws_instance" "ec2" {
  ami           = "ami-064446ad1d755489e"
  instance_type = "t2.micro"
  key_name = var.ec2_keypair
  count = var.ec2_count
  vpc_security_group_ids = ["${aws_security_group.ec2-sg.id}"]
  subnet_id = element(var.subnets, count.index)

  tags = {
    Name = "${var.environment}-${count.index+1}"
  }
}

variable "ec2_count" {
  type = number
  default = "3"

variable "environment" {
  default = "Prod"
}

resource "aws_security_group" "ec2-sg" {
  name        = "${var.environment}-ec2-sg"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}

