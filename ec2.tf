provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA6BZ5HY45VPMCCEGY"
  secret_key = "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"
}


resource "aws_instance" "Web_1" {
  ami                     = "ami-06e46074ae430fba6"
  instance_type           = "t2.micro"
  subnet_id  ="subnet-0f5c6a01eb1d212e9"
  vpc_security_group_ids = ["sg-09bafe64c49d697d6"]
  
  tags = {
    Name = "Server_1"
  }

}



