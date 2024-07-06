# variables.tf
variable "aws_region_1" {
  default = "us-east-1"
}

variable "aws_region_2" {
  default = "us-west-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "project"
}
