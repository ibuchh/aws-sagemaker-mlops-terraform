# ---------------------------------------------------------------------------------------------------------------------
# S3 bucket for ML model
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_s3_bucket" "model_bucket" {
  bucket_prefix = "jenkins-scikitbyo-modelartifact-"
  acl    = "private"

  tags = {
    Name        = "jenkins-scikitbyo-modelartifact"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# S3 bucket for training & test data
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_s3_bucket" "training_test_bucket" {
  bucket_prefix = "jenkins-scikitbyo-training-test-"
  acl    = "private"

  tags = {
    Name        = "jenkins-scikitbyo-training-test"
  }
}

resource "aws_s3_bucket_object" "train" {
    bucket = aws_s3_bucket.training_test_bucket.id
    # acl    = "private"
    key    = "train/train.csv"
    source = "../data/train/train.csv"
}


output "model_bucket_name" {
  value = aws_s3_bucket.model_bucket.bucket
}

output "data_bucket_name" {
  value = aws_s3_bucket.training_test_bucket.bucket
}