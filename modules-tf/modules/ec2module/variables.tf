variable "ami" {
    description = "the AWS AMI"
    type = string
}

variable "instancetype" {
    description = "Type of instance"
    type = string
}

variable aws_tag {
  type = map
  description = "tags aws"
  default = {
    Name: "ec2"}
}

variable "key" {
    default = "tf"
}

variable "sg_name" {
    type = string
    default = "azed01-sg"
}