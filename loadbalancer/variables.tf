variable "cidr" {
  description = "IP range for VPC"
}

variable "sub1Cidr" {
  description = "IP range for sub1"
}

variable "sub2Cidr" {
  description = "IP range for sub2"
}

variable "ami" {
    description = "AMI id for instance"
}

variable "instance_type" {
  description = "Instance type"
}