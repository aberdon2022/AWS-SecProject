variable "region" {
  description = "AWS region"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive = true
}