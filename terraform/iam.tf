# ---------------------------------------------------------------------------------------------------------------------
# SageMaker Role
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_iam_role" "role" {
  name = "MLOps-SageMaker-ExecutionRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "sagemaker.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "example-SageMakerFullAccess" {
    role       =  aws_iam_role.role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
    
}

output "sagemaker_role_name" {
  value = aws_iam_role.role.arn
}
