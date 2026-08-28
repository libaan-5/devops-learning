variable "vpc_id" {
  type        = string
  default     = "vpc-00419bf7cac73a9a4"
}

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

variable "key_pair" {
  type        = string
  default     = "vpc-keypair"
}

variable "subnet_id" {
  type        = string
  default     = "subnet-06f60f969733a6eda"
}
