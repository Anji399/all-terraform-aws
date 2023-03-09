provider "aws" {
    region =   "us-east-1"
    profile = "default"
}

resource "aws_instance" "VM1" {
  ami           = "ami-006dcf34c09e50022"
  instance_type = "t2.micro"
  key_name = "demo"
  count = "1"
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  subnet_id = aws_subnet.my-pub-1.id

  tags = {
    Name = "VM1"
  }
}

resource "aws_instance" "db1" {
  ami           = "ami-006dcf34c09e50022"
  instance_type = "t2.micro"
  key_name = "demo"
  count = "1"
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  subnet_id = aws_subnet.nat-sub.id

  tags = {
    Name = "db1"
  }
}

