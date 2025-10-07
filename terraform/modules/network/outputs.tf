output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "opencanary_sg_id" {
  value = aws_security_group.opencanary_sg.id
}

output "s3_endpoint_id" {
  value = aws_vpc_endpoint.s3_ep.id
}