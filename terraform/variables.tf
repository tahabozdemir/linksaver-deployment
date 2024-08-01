variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "ec2_type" {
  type    = string
  default = "t2.micro"
}

variable "ec2_key_name" {
  type    = string
  default = "linksaver-ec2-key"
}