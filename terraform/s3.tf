resource "aws_s3_bucket" "bucket" {
  bucket = "purchase-app-backet"
  acl = "public-read"

  tags = {
    Nmae = "purchase-app-backet"
    Environment = "Production"
  }
}
