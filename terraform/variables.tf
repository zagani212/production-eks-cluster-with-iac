# VPC variables
variable "vpc_cidr" {}
variable "public_cidr1" {}
variable "public_cidr2" {}
variable "private_cidr1" {}
variable "private_cidr2" {}


# Node Group
variable "ami_type" {}
variable "instance_types" {}
variable "desired_size" {}
variable "min_size" {}
variable "max_size" {}
variable "max_unavailable" {}