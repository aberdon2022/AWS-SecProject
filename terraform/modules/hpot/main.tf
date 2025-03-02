resource "aws_instance" "cowrie" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install awscli -y
              
              aws configure set aws_access_key_id ${var.aws_access_key}
              aws configure set aws_secret_access_key ${var.aws_secret_key}
              aws configure set default.region ${var.region}
              EOF
  tags = {
    Name = "Cowrie"
  }
}