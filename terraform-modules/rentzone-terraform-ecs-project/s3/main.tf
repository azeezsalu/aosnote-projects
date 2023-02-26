# create an s3 bucket 
resource "aws_s3_bucket" "env_file_bucket" {
  bucket = "${}-${}"

  lifecycle {
    create_before_destroy = 
  }
}

# upload the environment file from local computer into the s3 bucket
resource "aws_s3_object" "upload_env_file" {
  bucket = 
  key    = 
  source = "./${}"
}