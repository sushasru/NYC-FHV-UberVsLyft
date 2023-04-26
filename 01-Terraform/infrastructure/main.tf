resource "aws_s3_bucket" "tripdata" {
  bucket = "nyc-fhvhv-tripdata-test"
}

resource "aws_s3_bucket_ownership_controls" "tripdata" {
  bucket = aws_s3_bucket.tripdata.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "tripdata" {
  bucket = aws_s3_bucket.tripdata.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "tripdata" {
  depends_on = [
    aws_s3_bucket_ownership_controls.tripdata,
    aws_s3_bucket_public_access_block.tripdata,
  ]

  bucket = aws_s3_bucket.tripdata.id
  acl    = "public-read"
}