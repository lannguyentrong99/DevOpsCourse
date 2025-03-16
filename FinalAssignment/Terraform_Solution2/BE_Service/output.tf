output "bucket_name" {
  value = aws_s3_bucket.static_website_bucket.bucket
}

output "bucket_endpoint" {
  value = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}