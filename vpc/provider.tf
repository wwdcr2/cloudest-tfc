#Initialize the AWS Provider = 아래 계정 정보로 활동!
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = var.aws_region
}