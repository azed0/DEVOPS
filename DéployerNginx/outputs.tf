output "instance_id" {
  value = aws_instance.ec2.id
}


output "public_ip" {
  value = aws_eip.eip.public_ip
}
output "availability_zone" {
  value = aws_instance.ec2.availability_zone
}
