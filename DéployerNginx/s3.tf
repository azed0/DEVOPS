resource "aws_s3_bucket" "s3" {
    bucket = "azed01-tfstate"
    acl = "private"
    tags = {
        Name = "mybucket"
    }
    provisioner "local-exec" {
        command = "echo 'Bucket_Name : ${aws_s3_bucket.s3.bucket}' >> info.txt"
    }
}
resource "aws_s3_bucket_versioning" "versioning" {
    bucket = aws_s3_bucket.s3.id
    versioning_configuration {
      status = "Enabled"
    }
  
}

