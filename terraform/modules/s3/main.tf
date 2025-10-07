resource "random_id" "random_hex" {
  byte_length = 8
}

resource "aws_s3_bucket" "logs" {
  bucket = format("%s-%s", "hpot-logs", random_id.random_hex.hex)
  tags = {
    Name = "hpot-logs"
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
        Effect = "Allow"
        Principal = "*"
        Action = ["s3:*"]
        Resource = [
          aws_s3_bucket.logs.arn,
          "${aws_s3_bucket.logs.arn}/*",
        ]
        Condition = {
          StringEquals = {
            "aws:sourceVpce" = var.vpc_endpoint_id
          }
        }
      }
    ]
  })
}