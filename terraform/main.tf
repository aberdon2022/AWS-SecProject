provider "aws" {
  region = var.region
}

resource "aws_key_pair" "keyPair" {
  key_name = "hpot_key"
  public_key = file(var.sshKey)
}

module "network" {
  source = "./modules/network"
  vpc_cidr = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  region = var.region
}

module "s3" {
  source = "./modules/s3"
  vpc_endpoint_id = module.network.s3_endpoint_id
}

module "hpot" {
  source = "./modules/hpot"
  ami = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.keyPair.key_name
  subnet_id = module.network.public_subnet_id
  vpc_security_group_ids = [module.network.hpot_sg_id]
  bucket_name = module.s3.bucket_name
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  region = var.region
}