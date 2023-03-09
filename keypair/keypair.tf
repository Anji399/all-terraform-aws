provider "aws" {
  region = "us-east-1"
}  
resource "aws_key_pair" "demo" {
  key_name   = "sample"
  public_key = file("sample.pub")
}


#ssh-keygen

#          :sample