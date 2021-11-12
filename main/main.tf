/**************************************
*
* Terraform Project Main configuration
*
***************************************/

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

# Create a bucket AWS S3
resource "aws_s3_bucket" "s3_example" {
  bucket = "bucket-flugel"
  acl    = "private" # or can be "public-read"
  tags = {
    Name        = "Flugel"
    Environment = "Dev"
    Owner       = "InfraTeam"
  }
  versioning {
    enabled = true
  }
}

#  Create a AWS EC2 Instance
resource "aws_instance" "ec2_example" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
  tags = {
    Name        = "Flugel"
    Environment = "Dev"
    Owner       = "InfraTeam"
  }
}

# variables for automation testing
output "bucket_id" {
  value = trimspace(aws_s3_bucket.s3_example.id)
}

output "instance_id" {
  //value = "${aws_instance.ec2_example.tags.Name}"
  value = trimspace(aws_instance.ec2_example.tags.Name)
}
