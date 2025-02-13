variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.10.10.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.10.10.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.10.11.0/24"
}
