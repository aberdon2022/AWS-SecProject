packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

variable "vpc_id" {
  type        = string
  default = ""
}

variable "subnet_id" {
  type        = string
    default = ""
}

source "amazon-ebs" "honeypot_ami" {
  ami_name      = "honeypot-ami_{{timestamp}}"
  instance_type = "t2.micro"
  region        = "eu-west-3"
  source_ami    = "ami-0fc9df40a6c4cc53c" // Ubuntu 22.04 LTS AMD64
  ssh_username  = "ubuntu"
  vpc_id       = var.vpc_id
  subnet_id    = var.subnet_id

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }
  imds_support = "v2.0"

}

build {
  sources = ["source.amazon-ebs.honeypot_ami"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y awscli",
      "sudo apt-get install python3-dev python3-pip python3-virtualenv python3-venv python3-scapy libssl-dev libpcap-dev -y",
      "sudo adduser --disabled-password --gecos \"\" opencanary",
      "sudo -u opencanary python3 -m venv /home/opencanary/.venv",
      "sudo -u opencanary /home/opencanary/.venv/bin/pip install opencanary",
      "sudo mkdir /etc/opencanary",
      "sudo cp /home/opencanary/.venv/lib/python3.10/site-packages/opencanary/data/settings.json /etc/opencanary/opencanary.conf",
      "sync"
    ]
  }

  post-processor "manifest" {
    output = "manifest.json"
  }
}


