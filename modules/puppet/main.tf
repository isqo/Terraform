
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

data "aws_ami" "redhat-linux-8" {
  most_recent = true
  owners      = ["309956199498"]
  filter {
    name   = "name"
    values = ["RHEL-8.*"]
  }
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

resource "aws_instance" "agent1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = var.private_key
  vpc_security_group_ids  = [var.aws_security_group_instance]
  user_data = <<EOF
#!/bin/bash
  echo "${var.puppetserver_private_ip}" puppet >> /etc/hosts
  bash <(curl -s https://raw.githubusercontent.com/isqo/Terraform/refs/heads/main/userdata/setup_puppet_agent.sh)
  EOF
  tags = {
    Name = "Apache"
  }
}
  resource "aws_ec2_instance_state" "Stop_agent1" {
    instance_id = aws_instance.agent1.id
    state       = "stopped"
  }

resource "aws_instance" "agent2" {
  ami           = data.aws_ami.redhat-linux-8.id 
  instance_type = "t2.micro"
  key_name = var.private_key
  vpc_security_group_ids  = [var.aws_security_group_instance]
  user_data = <<EOF
#!/bin/bash
  echo "${var.puppetserver_private_ip}" puppet >> /etc/hosts
  bash <(curl -s https://raw.githubusercontent.com/isqo/Terraform/refs/heads/main/userdata/setup_puppet_agent_red_hat.sh)
  EOF
  tags = {
    Name = "Jenkins"
  }
}
resource "aws_ec2_instance_state" "agent2" {
  instance_id = aws_instance.agent2.id
  state       = "running"
}

resource "aws_instance" "agent3" {
  ami           = data.aws_ami.redhat-linux-8.id 
  instance_type = "t2.micro"
  key_name = var.private_key
  vpc_security_group_ids  = [var.aws_security_group_instance]
  user_data = <<EOF
#!/bin/bash
  echo "${var.puppetserver_private_ip}" puppet >> /etc/hosts
  bash <(curl -s https://raw.githubusercontent.com/isqo/Terraform/refs/heads/main/userdata/setup_puppet_agent_red_hat.sh)
  EOF
  tags = {
    Name = "puppetdb"
  }
}
resource "aws_ec2_instance_state" "agent3" {
  instance_id = aws_instance.agent3.id
  state       = "stopped"
}

resource "aws_instance" "agent5" {
  ami           = data.aws_ami.redhat-linux-8.id 
  instance_type = "t2.micro"
  key_name = var.private_key
  vpc_security_group_ids  = [var.aws_security_group_instance]
  user_data = <<EOF
#!/bin/bash
  echo "${var.puppetserver_private_ip}" puppet >> /etc/hosts
  bash <(curl -s https://raw.githubusercontent.com/isqo/Terraform/refs/heads/main/userdata/setup_puppet_agent_red_hat.sh)
  EOF
  tags = {
    Name = "postgres"
  }
}

resource "aws_ec2_instance_state" "agent5" {
  instance_id = aws_instance.agent5.id
  state       = "stopped"
}


resource "aws_instance" "agent4" {
  ami           = data.aws_ami.redhat-linux-8.id 
  instance_type = "t2.micro"
  key_name = var.private_key
  vpc_security_group_ids  = [var.aws_security_group_instance]
  user_data = <<EOF
#!/bin/bash
  echo "${var.puppetserver_private_ip}" puppet >> /etc/hosts
  bash <(curl -s https://raw.githubusercontent.com/isqo/Terraform/refs/heads/main/userdata/setup_puppet_agent_red_hat.sh)
  EOF
  tags = {
    Name = "rundeck"
  }
}

resource "aws_ec2_instance_state" "agent4" {
  instance_id = aws_instance.agent4.id
  state       = "stopped"
}

resource "aws_instance" "agent6" {
  ami           = data.aws_ami.redhat-linux-8.id 
  instance_type = "t2.micro"
  key_name = var.private_key
  vpc_security_group_ids  = [var.aws_security_group_instance]
  user_data = <<EOF
#!/bin/bash
  echo "${var.puppetserver_private_ip}" puppet >> /etc/hosts
  bash <(curl -s https://raw.githubusercontent.com/isqo/Terraform/refs/heads/main/userdata/setup_puppet_agent_red_hat.sh)
  EOF
  tags = {
    Name = "Hashicorp Vault"
  }
}

resource "aws_ec2_instance_state" "agent6" {
  instance_id = aws_instance.agent6.id
  state       = "stopped"
}

resource "aws_instance" "test" {
  ami           = data.aws_ami.redhat-linux-8.id 
  instance_type = "t2.micro"
  key_name = var.private_key
  vpc_security_group_ids  = [var.aws_security_group_instance]
  tags = {
    Name = "test"
  }
}