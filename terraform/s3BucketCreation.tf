provider "aws" {
  region = "eu-central-1"
  access_key = "secret"
  secret_key = "secret"
}

resource "aws_s3_bucket" "b" {
  bucket = "coding-challenge-bucket"
  acl    = "private"
  tags = {
   env  = "dev"
  }
  versioning {
    enabled = true
  }
}

#resource "aws_s3_bucket_object" "b-object" {
#for_each = fileset("/Users/kalyanpakala/Documents/Sample-Data", "**/*")
#bucket = aws_s3_bucket.b.id
#key = each.value
#source = "/Users/kalyanpakala/Documents/Sample-Data/${each.value}"
#etag = filemd5("/Users/kalyanpakala/Documents/Sample-Data/${each.value}")
#}

variable "upload_dir" {
  default = "/Users/kalyanpakala/Documents/Sample-Data/"
}

resource "aws_s3_bucket_object" "b_objects" {
  for_each      = fileset(var.upload_dir, "**/*.*")
  bucket        = aws_s3_bucket.b.id
  key           = replace(each.value, var.upload_dir, "")
  source        = "${var.upload_dir}${each.value}"
  acl           = "private"
  etag          = filemd5("${var.upload_dir}${each.value}")
}
