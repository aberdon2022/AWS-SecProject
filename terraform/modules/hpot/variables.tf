variable "ami" {
  description = "Value of the AMI"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "key_name" {
  description = "SSH Key Name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Security Group ID"
  type        = list(string)
}

variable "bucket_name" {
  description = "Bucket Name"
  type        = string
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

variable "region" {
  description = "AWS region"
  type        = string
}