variable "vpc_name" {}
variable "agent_count" {
    default = "1"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    default = "10.0.1.0/24"
}

variable "aws_region" {
    default = "us-west-2"
}
