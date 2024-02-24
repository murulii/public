provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}


//Creating Bucket
resource "aws_s3_bucket" "cherrymu" {
  bucket = "cherrymu"
  
}




//Creating Instance
resource "aws_instance" "ec2" {

  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  tags = {
    Name = "Webserver"
  }
}


//Creating Dynamo Db Table
resource "aws_dynamodb_table" "LockID" {
  name           = "LockID"
  billing_mode   = "PAY_PER_REQUEST"
  
  hash_key       = "LockID"
  

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "LockID"
    Environment = "production"
  }
}