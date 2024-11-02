variable "accesskey" {
    type = string
    description = "the AWS access key"  
}

variable "secretkey" {
    type = string
    description = "the AWS secret key"
}

variable "region" {
    type = string
    description = "the default region"
}

variable "instancetype" {
    description = "instance type Of EC2"
    type = string
}

variable "key" {
    default = "tf"
    description = "the AWS key"
}

variable aws_tag {
  type = map
  description = "tags aws"
  default = {
    Name: "ec2"}
}
variable "ami" {
    type= string
    description = "the AMI of the EC2"
}