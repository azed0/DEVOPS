resource "aws_instance" "ec2" {
    ami = var.ami
    instance_type = var.instancetype
    tags = var.aws_tag
    key_name = var.key
    security_groups = [ aws_security_group.sg.name ]

    provisioner "remote-exec" {
        connection {
          type = "ssh"
          user = "ubuntu"
          private_key = file("./tf.pem")
          host = self.public_ip
        }
    inline = [ 
        "sudo apt-get update && sudo apt-get upgrade -y",
        "sudo apt-get install nginx -y",
        "sudo systemctl start nginx && sudo systemctl enable nginx"
     ]  
    }
}

resource "aws_security_group" "sg" {
    name = var.sg_name
    description = "allow http & ssh"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

resource "aws_eip" "eip" {
    instance = aws_instance.ec2.id
    provisioner "local-exec" {
        command = "echo PUBLIC IP: ${aws_eip.eip.public_ip} ; ID: ${aws_instance.ec2.id} ; AZ: ${aws_instance.ec2.availability_zone}; >> infos_ec2.txt"
    }
  
}