output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "hpot_sg_id" {
  value = aws_security_group.hpot_sg.id
}

output "s3_endpoint_id" {
  value = aws_vpc_endpoint.s3_endpoint.id
}