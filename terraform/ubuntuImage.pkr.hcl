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
      "sudo mkdir /etc/opencanaryd",
      "sudo cp /home/opencanary/.venv/lib/python3.10/site-packages/opencanary/data/settings.json /etc/opencanaryd/opencanary.conf",
      "sudo systemctl disable --now ssh",
      "sudo systemctl mask ssh",
      "sudo sed -i 's/\"http.enabled\": false/\"http.enabled\": true/' /etc/opencanaryd/opencanary.conf",
      "sudo sed -i 's/\"telnet.enabled\": false/\"telnet.enabled\": true/' /etc/opencanaryd/opencanary.conf",
      "sudo sed -i 's/\"mssql.enabled\": false/\"mssql.enabled\": true/' /etc/opencanaryd/opencanary.conf",
      "sudo sed -i 's/\"vnc.enabled\": false/\"vnc.enabled\": true/' /etc/opencanaryd/opencanary.conf",
      "sudo sed -i 's/\"ssh.enabled\": false/\"ssh.enabled\": true/' /etc/opencanaryd/opencanary.conf",
      "sudo sed -i 's/\"mysql.enabled\": false/\"mysql.enabled\": true/' /etc/opencanaryd/opencanary.conf",
      "sudo sed -i 's/\"device.node_id\": \"opencanary-1\"/\"device.node_id\": \"app-aws-01\"/' /etc/opencanaryd/opencanary.conf",
      "sync"
    ]
  }
}


