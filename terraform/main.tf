provider "aws" {
  region = var.region
}

resource "aws_key_pair" "keyPair" {
  key_name = "hpot_key"
  public_key = file(var.sshKey)
}