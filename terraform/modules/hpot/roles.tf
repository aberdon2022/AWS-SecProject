data "aws_caller_identity" "current" {}

resource "aws_iam_role" "hpot_ec2" {
  name = "hpot_ec2"

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

resource "aws_iam_policy" "ssm" {
  name = "hpot_ssm_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Sid = "EnableSSMSession"
            Effect = "Allow"
            Action = "ssm:StartSession"
            Resource = [
                "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:document/SSM-SessionManagerRunShell",
                "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:document/AWS-StartNonInteractiveCommand",
                "arn:aws:ec2:${var.region}:${data.aws_caller_identity.current.account_id}:instance/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": ["ssm:ResumeSession","ssm:TerminateSession"],
            "Resource": "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:session/*"
        }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "ssm_attachment" {
  policy_arn = aws_iam_policy.ssm.arn
  group      = "AdminGroup"
}

resource "aws_iam_policy" "hpot" {
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

resource "aws_iam_role_policy_attachment" "hpot_attachment" {
  policy_arn = aws_iam_policy.hpot.arn
  role = aws_iam_role.hpot_ec2.name
}

resource "aws_iam_role_policy_attachment" "hpot_ssm" {
  role       = aws_iam_role.hpot_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "hpot_instance_profile" {
  name = "hpot_instance_profile"
  role = aws_iam_role.hpot_ec2.name
}