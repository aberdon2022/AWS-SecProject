variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "Value of the AMI"
  type        = string

}