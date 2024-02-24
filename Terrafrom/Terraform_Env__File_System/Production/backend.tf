
//State Lock Information and Remote Backend

terraform {
  backend "s3" {
    bucket = "cherrymu"
    key    = "Production/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "LockID"
  }
}
