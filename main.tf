
variable "env" {
  default="dev"
  
}
data "template_file" "ec2_user_data" {
  template = "${file("${path.module}/install_docker_machine_compose.sh")}"
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
  user_data =  "${data.template_file.ec2_user_data.template}"
  key_name="linux-key"
  security_groups = ["swarm_sg"]
  tags = {
    Name = "i-${var.env}"
  }
  
}
