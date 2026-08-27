variable "instance_type" {
  type        = string
  default     = "t3.micro"
}

variable "terraform_source" {
  type        = string
  default     = "hashicorp/aws"
}

variable "terraform_version" {
  type        = string
  default     = "~> 6.0"
}

variable "region" {
  type        = string
  default     = "eu-west-2"
}

variable "ami_id" {
  type        = string
  default     = "ami-06f9e3b45a89cf4aa"
}
