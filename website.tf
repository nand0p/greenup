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


data "aws_route53_zone" "hex7" {
  name = "hex7.com."
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


#resource "aws_route53_record" "greenup" {
#  depends_on = [ aws_s3_bucket.greenup ]
#  zone_id = data.aws_route53_zone.hex7.zone_id
#  name    = "${var.bucket}."
#  type    = "A"
#  alias {
#    name                   = aws_s3_bucket_website_configuration.greenup.website_domain
#    zone_id                = aws_s3_bucket.greenup.hosted_zone_id
#    evaluate_target_health = true
#  }
#}
