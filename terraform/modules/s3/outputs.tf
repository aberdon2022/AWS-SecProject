output "bucket_id" {
  value = aws_s3_bucket.logs.id
}

output "bucket_name" {
  value = aws_s3_bucket.logs.bucket
}