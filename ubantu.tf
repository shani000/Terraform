provider "aws" {
    region = "us-east-2"
    access_key = "AKIA2HGKR75R3TDH3E76"
    secret_key = "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"
}

resource "aws_instance" "ec2" {
  ami           = "ami-08962a4068733a2b6"
  instance_type = "t2.micro"
  key_name = "Vishnu1"
  count = var.ec2_count
  vpc_security_group_ids = ["${aws_security_group.ec2-sg5.id}"]


  tags = {
    Name = "${var.environment}-${count.index+1}"
  }
}

variable "ec2_count" {
  type = number
  default = "3"
}
variable "environment" {
  default = "Prod"
}

resource "aws_security_group" "ec2-sg5" {
  name        = "${var.environment}-ec2-sg5"

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
    Name = "ec2-sg5"
  }
}
