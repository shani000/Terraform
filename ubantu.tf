provider "aws" {
    region = "us-east-2"
    profile = "default"
}

resource "aws_instance" "ec2" {
  ami           = "ami-08962a4068733a2b6"
  instance_type = "t2.micro"
  key_name = "dineshKey"
  count = var.ec2_count
  vpc_security_group_ids = ["${aws_security_group.ec2-sg_3.id}"]


  tags = {
    Name = "${var.environment}-${count.index+1}"
  }
}

variable "ec2_count" {
  type = number
  default = "4"
}
variable "environment" {
  default = "Production"
}

resource "aws_security_group" "ec2-sg_3" {
  name        = "${var.environment}-ec2-sg_3"

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
    Name = "ec2-sg_3"
  }
}
