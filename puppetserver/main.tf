
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" {}
variable "private_key" {}
variable "aws_security_group_instance" {}

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

resource "aws_instance" "puppetserver" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  key_name = var.private_key
  vpc_security_group_ids  = [var.aws_security_group_instance]
  user_data = <<EOF
#!/bin/bash
      # wget https://apt.puppet.com/puppet7-release-focal.deb
      # sudo dpkg -i puppet7-release-focal.deb
      # sudo apt update
      # sudo apt-get install puppetserver
      # sudo service puppetserver start
      # puppetserver --versio
  EOF
  tags = {
    Name = "puppetserver"
  }
}

