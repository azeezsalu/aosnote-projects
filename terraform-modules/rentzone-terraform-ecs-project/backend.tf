# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = 
    key            = 
    region         = 
    profile        = 
    dynamodb_table = 
  }
}