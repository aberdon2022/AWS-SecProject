resource "aws_instance" "cowrie" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install git python3-venv libssl-dev libffi-dev build-essential libpython3-dev python3-minimal authbind -y
              sudo adduser --disabled-password cowrie
              sudo su - cowrie
              git clone https://github.com/cowrie/cowrie.git
              cd cowrie
              python3 -m venv cowrie-env
              source cowrie-env/bin/activate
              python3 -m pip install --upgrade pip
              python3 -m pip install --upgrade -r requirements.txt
              EOF
  tags = {
    Name = "Cowrie"
  }
}