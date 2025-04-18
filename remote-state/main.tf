provider "aws" {
  region = "us-east-2"
  profile= "Nabilah"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "nabilah-docker-tfstate"
     
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
    bucket = aws_s3_bucket.terraform_state.id

    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "app-state"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "terra"

  attribute {
    name = "terra"
    type = "S"
  }
}
