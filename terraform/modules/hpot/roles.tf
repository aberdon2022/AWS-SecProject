resource "aws_iam_role" "hpot_ec2_role" {
  name = "hpot_ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "hpot_policy" {
  name = "hpot_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject",
        ]
        Sid = "AllowLogsInS3"
        Effect = "Allow"
        Resource = [
          "${aws_s3_bucket.logs.arn}/*",
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "hpot_policy_attachment" {
  policy_arn = aws_iam_policy.hpot_policy.arn
  role = aws_iam_role.hpot_ec2_role.name
}

resource "aws_iam_instance_profile" "hpot_instance_profile" {
  name = "hpot_instance_profile"
  role = aws_iam_role.hpot_ec2_role.name
}