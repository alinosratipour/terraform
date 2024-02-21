terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "eu-west-2"
  
}

resource "aws_security_group" "ali-new_ec2_security_group" {
  name        = "ali-new-ec2-security-group"
  description = "New security group for EC2 instance via terraform"

  vpc_id = "vpc-0e4b35bc363255234"  

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  
  }
}
resource "aws_instance" "ali-ec2-todo-app" {
  instance_type = ""
  ami             = "ami-0e5f882be1900e43b"   
  tags                                 = {
 "Name" = "ali-ec2-todo-app" 
        }
}

resource "aws_s3_bucket" "ali_bucket" {
  bucket = "ali-s3-todo-app"
}

resource "aws_s3_bucket_public_access_block" "ali_bucket_public_access_block" {
  bucket = aws_s3_bucket.ali_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


# RDS
# resource "aws_db_instance" "todo_db" {
#   allocated_storage = 20 
#   engine            = "postgres"  
#   instance_class    = "db.t3.micro"  
#   username          = "postgres"  
#   password          = var.db_password 

# }
