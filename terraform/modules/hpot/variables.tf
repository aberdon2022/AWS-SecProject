variable "ami" {
  description = "Value of the AMI"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
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

variable "region" {
  description = "AWS region"
  type        = string
}

variable "logs_bucket_arn" {
  description = "ARN S3 logs"
  type        = string
}