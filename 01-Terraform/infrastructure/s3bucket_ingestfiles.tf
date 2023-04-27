resource "aws_s3_object" "sourcefiles" {
  for_each = fileset("../files/", "*.*")
  bucket   = aws_s3_bucket.tripdata.id
  key      = each.value
  source   = "../files/${each.value}"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("../files/${each.value}")
}