
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" {}
variable "private_key" {}

data "aws_security_group" "selected" {
  id ="sg-068f6a2472c023f3e"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "nginx" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = var.private_key
  vpc_security_group_ids  = [data.aws_security_group.selected.id]
  user_data = <<EOF
#!/bin/bash
      sudo apt update
      sudo apt install -y nginx
      sudo systemctl enable nginx
      sudo systemctl start nginx
  EOF
  tags = {
    Name = "nginx"
  }
}

