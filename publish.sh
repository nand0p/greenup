#!/bin/bash -ex


PORT=5000
S3_BUCKET=greenup.hex7.com

echo "purging temporary directory"
rm -v greenup/*

wget --recursive \
     --no-directories \
     --no-host-directories \
     --adjust-extension \
     --no-cache \
     --no-cookies \
     --directory-prefix=greenup \
     --default-page=index.html \
     localhost:${PORT}


echo "S3 Bucket: ${S3_BUCKET}"
aws s3 mb s3://${S3_BUCKET} || true
aws s3 ls s3://${S3_BUCKET}

echo "s3 make static path"
aws s3 mb s3://${S3_BUCKET}/static
aws s3api put-object-acl --bucket ${S3_BUCKET} --key static/

echo "publish greenup s3://${S3_BUCKET}"
aws s3 cp greenup/index.html s3://${S3_BUCKET}/index.html
aws s3 cp static/greenup.png s3://${S3_BUCKET}/static/greenup.png
aws s3 cp static/robots.txt s3://${S3_BUCKET}/static/robots.txt
aws s3 cp static/favicon.ico s3://${S3_BUCKET}/static/favicon.ico

echo "put object acl"
aws s3api put-object-acl --bucket ${S3_BUCKET} --key index.html --acl public-read
aws s3api put-object-acl --bucket ${S3_BUCKET} --key robots.txt --acl public-read
aws s3api put-object-acl --bucket ${S3_BUCKET} --key favicon.ico --acl public-read
