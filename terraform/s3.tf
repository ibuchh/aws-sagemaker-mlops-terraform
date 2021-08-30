# ---------------------------------------------------------------------------------------------------------------------
# S3 bucket for ML model
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket_prefix = "jenkins-scikitbyo-modelartifact-"
  acl    = "private"

  tags = {
    Name        = "jenkins-scikitbyo-modelartifact"
  }
}
