resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-3a"
  map_public_ip_on_launch= true
  tags = {
    Name = "Public AZ a"
  }
}
resource "aws_subnet" "public_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-3b"
  map_public_ip_on_launch= true
  tags = {
    Name = "Public AZ b"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "eu-west-3a"
  tags = {
    Name = "Private AZ a"
  }
}
resource "aws_subnet" "private_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "eu-west-3b"
  tags = {
    Name = "Private AZ b"
  }
}

resource "aws_eip" "nat1" {
  domain = "vpc"
}
resource "aws_eip" "nat2" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main_1" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.public_1.id

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "main_2" {
  allocation_id = aws_eip.nat2.id
  subnet_id     = aws_subnet.public_2.id

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "pub_r" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "pri_r1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_1.id
  }

  tags = {
    Name = "main"
  }
}
resource "aws_route_table" "pri_r2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_2.id
  }

  tags = {
    
    Name = "main"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.pub_r.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.pub_r.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.pri_r1.id
}
resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.pri_r2.id
}