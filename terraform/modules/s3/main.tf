resource "aws_s3_bucket" "logs" {
  bucket = "hpot-logs-s3"
  force_destroy = true
  tags = {
    Name = "hpot-logs"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "logs" {
  bucket = aws_s3_bucket.logs.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls = true
}

resource "aws_s3_bucket_policy" "logs_policy" {
  bucket = aws_s3_bucket.logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Deny",
        Principal = "*",
        Action = "s3:*",
        Resource = [
          aws_s3_bucket.logs.arn,
          "${aws_s3_bucket.logs.arn}/*"
        ]
        Condition = {
          StringNotEquals = {
            "aws:sourceVpce" = var.vpc_endpoint_id
          }
        }
      }
    ]
  })
}