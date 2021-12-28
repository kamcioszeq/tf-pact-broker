variable "aws_ami" {
  description = "aws ami"
  #default="ami-07c1207a9d40bc3bd"
  default = "ami-083ebc5a49573896a"
}

variable "ebs_device_name" {
  default = "test_device"
}

#variable "key_name" {
#  description = "SSH key name in your AWS account for AWS instances."
#}

#variable "key_path" {
#  description = "Path to the private key specified by key_name."
#}

variable "aws_region" {
  default = "us-east-2"
  description = "The region of AWS, for AMI lookups."
}

variable "aws_vpc" {
  description = "The vpc to launch in"
  default = "vpc-00fa2e6b"
}

variable "db_username" {
  default = "user"
}

variable "db_password" {
  default = "password"
}

variable "db_host" {
  default = "localhost"
}

variable "db_name" {
  default = "testdb"
}
