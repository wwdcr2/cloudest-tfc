##########################################################################################
#AWS authentication variables
variable "aws_key_pair" {
  type = string
  description = "AWS Key Pair"
}
##########################################################################################
#AWS region
variable "aws_region" {
  description = "AWS region"
  default     = "ap-northeast-2"
}
##########################################################################################
#AWS AZ
variable "apr_az_a" {
  type = string
  description = "AWS AZ"
  default = "ap-northeast-2a"
}
variable "apr_az_c" {
  type = string
  description = "AWS AZ"
  default = "ap-northeast-2c"
}
##########################################################################################
#VPC생성
variable "apr_vpc_01_cidr" {
  type = string
  description = "CIDR for the VPC"
  default = "10.11.0.0/16"
}
##########################################################################################
#서브넷 생성
variable "apr_subnet_private_vpc01_prd_a01" {
  type = string
  description = "CIDR for the subnet"
  default = "10.11.1.0/24"
}
variable "apr_subnet_private_vpc01_prd_c01" {
  type = string
  description = "CIDR for the subnet"
  default = "10.11.2.0/24"
}