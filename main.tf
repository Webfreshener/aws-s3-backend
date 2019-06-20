provider "aws" {
  region = "${var.region}"
  profile = "${var.profile}"
}

# aws_kms_key._
resource "aws_kms_key" "_" {
  description = "bucket encryption key"
  deletion_window_in_days = 10
}

# aws_dynamodb_table._
resource "aws_dynamodb_table" "_" {
  name = "${var.prefix}-crypto-state-lock"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name = "State Lock Table"
  }
}

#  safe-store
#  encrypts and stores tfstate and other senstive files

# aws_s3_bucket._
resource "aws_s3_bucket" "_" {
  bucket = "${var.prefix}-crypto-safestore"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  server_side_encryption_configuration {
    "rule" {
      "apply_server_side_encryption_by_default" {
        kms_master_key_id = "${aws_kms_key._.arn}"
        sse_algorithm = "aws:kms"
      }
    }
  }
}
