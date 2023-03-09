resource "aws_internet_gateway" "my-IGW" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "my-IGW"
  }
}