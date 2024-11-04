provider "aws" {
    access_key = "**"
    secret_key = "**"
    region = "us-east-1"
}


module "ec2" {
    source = "../modules/ec2module"
    instancetype = "t2.micro"
    ami = "ami-0866a3c8686eaeeba"
    aws_tag = {
        Name = "ec2-prod-azed01"
    }
    sg_name = "azed01-sg-prod"
}
