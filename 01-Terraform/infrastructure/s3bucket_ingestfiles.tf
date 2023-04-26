resource "aws_s3_object" "SourceData" {
  bucket = "nyc-fhvhv-tripdata-test"
  key    = "nyc-fhvhv-tripdata-test/SourceData"
  source = "../files/Load_NYCFHVData_ToAWSS3.py"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("../files/Load_NYCFHVData_ToAWSS3.py")
}