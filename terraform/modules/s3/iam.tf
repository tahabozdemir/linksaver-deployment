resource "aws_iam_user" "s3_bucket_frontend_user" {
  name = var.s3_bucket_frontend_user_name
}

resource "aws_s3_bucket_policy" "s3_bucket_frontend_policy" {
  bucket = aws_s3_bucket.s3_bucket_frontend.id
  policy = data.aws_iam_policy_document.s3_bucket_frontend_policy_document.json
}

data "aws_iam_policy_document" "s3_bucket_frontend_policy_document" {
  statement {
    sid = "1s"

    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.s3_bucket_frontend_user.arn]
    }

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListMultipartUploadParts",
      "s3:AbortMultipartUpload"
    ]

    resources = [
      "${aws_s3_bucket.s3_bucket_frontend.arn}/*"
    ]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.s3_bucket_frontend_user.arn]
    }

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:ListBucketMultipartUploads"
    ]

    resources = [aws_s3_bucket.s3_bucket_frontend.arn]
  }
}