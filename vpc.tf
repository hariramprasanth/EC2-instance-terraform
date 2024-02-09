resource "aws_vpc" "web_server_vpc" {
  cidr_block = "10.0.0.0/28"
  tags = {
    Name = "web-server-vpc"
  }
}

resource "aws_subnet" "webserver_subnet" {
  vpc_id                  = aws_vpc.web_server_vpc.id
  cidr_block              = "10.0.0.0/28"
  availability_zone_id    = "aps1-az1"
  map_public_ip_on_launch = true
  tags = {
    Name = "webserver-subnet"
  }
}
resource "aws_internet_gateway" "web_server_ig" {
  vpc_id = aws_vpc.web_server_vpc.id


  tags = {
    Name = "web-server-ig"
  }
}

resource "aws_route_table" "web_server_route_table" {
  vpc_id = aws_vpc.web_server_vpc.id

  tags = {
    Name = "web-server-route-table"
  }
}

resource "aws_route_table_association" "webserver_subnet_vpc_route_table_association" {
  subnet_id      = aws_subnet.webserver_subnet.id
  route_table_id = aws_route_table.web_server_route_table.id

}

resource "aws_route" "web_server_route" {
  route_table_id         = aws_route_table.web_server_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.web_server_ig.id
}

