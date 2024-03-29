resource "aws_s3_bucket" "greenup"{
  bucket        = var.bucket
  force_destroy = true
  tags          = var.tags
}

resource "aws_s3_bucket_public_access_block" "greenup" {
  bucket                  = aws_s3_bucket.greenup.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_acl" "greenup" {
  depends_on = [
    #aws_s3_bucket_ownership_controls.greenup,
    aws_s3_bucket_public_access_block.greenup
  ]
  bucket = aws_s3_bucket.greenup.id
  acl    = "public-read"
}


resource "aws_s3_bucket_website_configuration" "greenup" {
  bucket = aws_s3_bucket.greenup.id
  index_document { suffix = "index.html" }
}


resource "aws_s3_bucket_policy" "greenup" {
  bucket = aws_s3_bucket.greenup.id
  policy = data.aws_iam_policy_document.greenup.json
}


data "aws_iam_policy_document" "greenup" {
  statement {
    sid    = "AllowPublicRead"
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${var.bucket}",
      "arn:aws:s3:::${var.bucket}/*",
    ]
    actions = ["S3:Get*", "S3:List*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "greenup" {
  bucket = aws_s3_bucket.greenup.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
