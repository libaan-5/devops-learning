variable "region" {
  type        = string
  default     = "eu-west-2"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
}

variable "ami" {
  type        = string
  default     = "ami-01c952cfc86b7870d"
}

variable "key_pair" {
  type        = string
  default     = "vpc-keypair-2"
}

variable "subnet_id" {
  type        = string
  default     = "subnet-06f60f969733a6eda"
}

variable "vpc_id" {
  type        = string
  default     = "vpc-00419bf7cac73a9a4"
}
