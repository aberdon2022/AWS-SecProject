variable "region" {
  description = "AWS region"
  type        = string
}

variable "sshKey" {
  description = "SSH key to access the EC2 instances"
  type        = string
  sensitive = true
}

