resource "aws_instance" "ec2" {
    ami = var.ami
    key_name = var.key
    instance_type = var.instancetype
    tags = var.aws_tag
    security_groups = [ aws_security_group.sg.name ]

    provisioner "remote-exec" {
        connection {
          type = "ssh"
          user = "ubuntu"
          private_key = file("./tf.pem")
          host = self.public_ip
        }
    
        inline = [ 
            "sudo apt-get update -y",
            "sudo apt-get upgrade -y",
            "sudo apt-get install nginx -y",
            "sudo systemctl start nginx",
            "sudo systemctl enable nginx"
        ]
      
    }
      
    
}

resource "aws_security_group" "sg" {
    name = "sg"
    description = "allow ssh & http"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permet HTTP depuis n'importe où
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
        command = <<EOT
      echo "Instance ID: ${self.id}" > infos.txt
      echo "Public IP: ${aws_eip.eip.public_ip}" >> infos.txt
      echo "AZ: ${aws_instance.ec2.availability_zone}" >> infos.txt
    EOT
    }
}

