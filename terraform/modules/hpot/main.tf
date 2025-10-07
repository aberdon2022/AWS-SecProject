resource "aws_instance" "opencanary" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile = aws_iam_instance_profile.hpot_instance_profile.name
  ebs_optimized = true

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    encrypted = true
    delete_on_termination = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
    http_put_response_hop_limit = 1
  }

  tags = {
    Name = "opencanary"
  }
}