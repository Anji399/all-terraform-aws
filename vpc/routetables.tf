resource "aws_route_table" "my-pub-RT" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-IGW.id
  }

  tags = {
    Name = "my-pub-RT"
  }
}


resource "aws_route_table_association" "my-pub-1-a" {
  subnet_id      = aws_subnet.my-pub-1.id
  route_table_id = aws_route_table.my-pub-RT.id
}

resource "aws_route_table_association" "my-pub-2-a" {
  subnet_id      = aws_subnet.my-pub-2.id
  route_table_id = aws_route_table.my-pub-RT.id
}
resource "aws_route_table_association" "my-pub-3-a" {
  subnet_id      = aws_subnet.my-pub-3.id
  route_table_id = aws_route_table.my-pub-RT.id
}
