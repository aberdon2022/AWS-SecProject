provider "aws" {
  region = var.region
}

module "network" {
  source = "./modules/network"
  vpc_cidr = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  region = var.region
}

module "s3" {
  source = "./modules/s3"
  vpc_endpoint_id = module.network.s3_endpoint_id
}

data "aws_ami" "hpot" {
  most_recent = true
  owners = ["self"]
  filter {
    name = "name"
    values = ["honeypot-ami_*"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

module "hpot" {
  source = "./modules/hpot"
  ami = data.aws_ami.hpot.id
  instance_type = var.instance_type
  subnet_id = module.network.public_subnet_id
  vpc_security_group_ids = [module.network.opencanary_sg_id]
  region = var.region
  logs_bucket_arn = module.s3.logs_bucket_arn
}