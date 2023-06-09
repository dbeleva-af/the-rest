terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu-1" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web-1" {
  ami           = data.aws_ami.ubuntu-1.id
  instance_type = var.instance_type

  tags = {
    Name = "Hello"
  }
}

resource "aws_instance" "web-2" {
  ami           = "ami-01ba8fe702263d044"
  instance_type = var.instance_type
  provider      = aws.ohio

  tags = {
    Name = "Hello"
  }
}

