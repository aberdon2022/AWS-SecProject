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

resource "aws_iam_policy" "ssm_policy" {
  name = "hpot_ssm_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Sid = "EnableSSMSession"
            Effect = "Allow"
            Action = "ssm:StartSession"
            Resource = [
                "arn:aws:ssm:*:*:document/SSM-SessionManagerRunShell",
                "arn:aws:ssm:*:*:document/AWS-StartNonInteractiveCommand",
                "arn:aws:ec2:*:*:instance/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssm:ResumeSession",
                "ssm:TerminateSession"
            ],
            "Resource": "*"
        }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "hpot_ssm_attachment" {
  policy_arn = aws_iam_policy.ssm_policy.arn
  user       = "admin"
}

resource "aws_iam_policy" "hpot_policy" {
  name = "hpot_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject"
        ]
        Effect = "Allow"
        Resource = [
          "${var.logs_bucket_arn}/*"
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "hpot_policy_attachment" {
  policy_arn = aws_iam_policy.hpot_policy.arn
  role = aws_iam_role.hpot_ec2_role.name
}

resource "aws_iam_role_policy_attachment" "hpot_ssm" {
  role       = aws_iam_role.hpot_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "hpot_instance_profile" {
  name = "hpot_instance_profile"
  role = aws_iam_role.hpot_ec2_role.name
}