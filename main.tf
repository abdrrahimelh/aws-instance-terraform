terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}
variable "env" {
  default="dev"
  
}
variable "region" {
  default="eu-west-3"
  
}
provider "aws" {
  profile = "default"
  region  = var.region
}


resource "aws_instance" "app_server" {
  ami           = "ami-0f7cd40eac2214b37"
  instance_type = "t2.micro"
  user_data = file("install_docker_machine_compose.sh")
  tags = {
    Name = "i-${var.env}"
  }
}