
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" {}
variable "private_key" {}
variable "aws_security_group_instance" {}
variable "puppetserver_private_ip" {}

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
  vpc_security_group_ids  = [var.aws_security_group_instance]
  user_data = <<EOF
#!/bin/bash
  bash <(curl -s https://raw.githubusercontent.com/isqo/Terraform/refs/heads/main/userdata/setup_puppet_agent.sh)
  echo "${var.puppetserver_private_ip}" puppet >> /etc/hosts
  bash <(curl -s https://raw.githubusercontent.com/isqo/Terraform/refs/heads/main/userdata/run_nginx.sh)
  EOF
  tags = {
    Name = "nginx"
    

  }
}