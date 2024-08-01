resource "aws_s3_bucket" "s3_bucket_frontend" {
  bucket        = var.s3_bucket_frontend_name
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_frontend_access" {
  bucket = aws_s3_bucket.s3_bucket_frontend.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}
