# variables.tf
variable "aws_region_1" {
  default = "us-east-2"
}

variable "aws_region_2" {
  default = "us-west-2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "project"
}
