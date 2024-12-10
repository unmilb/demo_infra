resource "aws_s3_bucket" "terraform-backend" {
  bucket = "${var.env}-terraform-state-bucket"
  tags = {
    Environment = "${var.env}"
  }
}

resource "aws_s3_bucket_accelerate_configuration" "terraform-backend" {
  bucket = aws_s3_bucket.terraform-backend.id
  status = "Enabled"
}

resource "aws_s3_bucket_versioning" "terraform-backend" {
  bucket = aws_s3_bucket.terraform-backend.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform-backend" {
  bucket = aws_s3_bucket.terraform-backend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform-backend" {
  bucket = aws_s3_bucket.terraform-backend.id
  # Block new public ACLs and uploading public objects
  block_public_acls = true
  # Retroactively remove public access granted through public ACLs
  ignore_public_acls = true
  # Block new public bucket policies
  block_public_policy = true
  # Retroactivley block public and cross-account access if bucket has public policies
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform-lock" {
  name           = "${var.env}-terraform-state-lock-dynamodb-table"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  point_in_time_recovery {
    enabled = true
  }
  server_side_encryption {
    enabled = true
  }
  tags = {
    Environment = "${var.env}"
  }
}
