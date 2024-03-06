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


echo "publish greenup s3://${S3_BUCKET}"
aws s3 cp greenup/index.html s3://${S3_BUCKET}/index.html
aws s3 sync static s3://${S3_BUCKET}/static

#echo "put object acl"
#aws s3api put-object-acl --bucket ${S3_BUCKET} --key index.html --acl public-read
#aws s3api put-object-acl --bucket ${S3_BUCKET} --key static/robots.txt --acl public-read
#aws s3api put-object-acl --bucket ${S3_BUCKET} --key static/favicon.ico --acl public-read
#aws s3api put-object-acl --bucket ${S3_BUCKET} --key static/greenup.png --acl public-read

echo "list s3 bucket"
aws s3 ls s3://${S3_BUCKET}
aws s3 ls s3://${S3_BUCKET}/static/

