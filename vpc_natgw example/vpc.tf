
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "my-pub-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "my-pub-1"
  }
}

resource "aws_subnet" "my-pub-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"
  tags = {
    Name = "my-pub-2"
  }
}

resource "aws_subnet" "my-pub-3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1c"
  tags = {
    Name = "my-pub-3"
  }
}

resource "aws_subnet" "nat-sub" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "nat-sub"
  }
}
resource "aws_internet_gateway" "my-IGW" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "my-IGW"
  }
}
resource "aws_default_route_table" "my-pub-RT" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-IGW.id
  }

  tags = {
    Name = "my-pub-RT"
  }
}

resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id      = aws_subnet.my-pub-1.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.my-IGW]
}

resource "aws_route_table" "my-nat-RT" {
    vpc_id = aws_vpc.main.id

    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
      Name = "my-nat-RT"
    } 
}           
resource "aws_route_table_association" "my-nat-RT-a" {
  subnet_id      = aws_subnet.nat-sub.id
  route_table_id = aws_route_table.my-nat-RT.id
}

resource "aws_route_table_association" "my-pub-1-a" {
  subnet_id      = aws_subnet.my-pub-1.id
  route_table_id = aws_default_route_table.my-pub-RT.default_route_table_id
}

resource "aws_route_table_association" "my-pub-2-a" {
  subnet_id      = aws_subnet.my-pub-2.id
  route_table_id = aws_default_route_table.my-pub-RT.default_route_table_id
}
resource "aws_route_table_association" "my-pub-3-a" {
  subnet_id      = aws_subnet.my-pub-3.id
  route_table_id = aws_default_route_table.my-pub-RT.default_route_table_id
}

