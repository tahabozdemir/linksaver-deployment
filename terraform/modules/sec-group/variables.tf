variable "sg_name" {
  type        = string
  description = "Name of the web security group"
  default     = "linksaver_sg"
}

variable "sg_description" {
  type        = string
  description = "Description of the web security group"
  default     = "Allow SSH, HTTP and HTTPS access to servers."
}

variable "allowed_ssh_ip" {
  description = "Allowed IP for SSH access"
  default     = "0.0.0.0/0"
}

variable "allowed_http_ip" {
  description = "Allowed IP for HTTP access"
  default     = "0.0.0.0/0"
}

variable "allowed_https_ip" {
  description = "Allowed IP for HTTPS access"
  default     = "0.0.0.0/0"
}

variable "linksaver_vpc_id" {
  type = string
}