resource "aws_subnet" "public" {
  count                   = length(local.Mumbai_Azs)
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = local.Mumbai_Azs[count.index]
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_Subnets-${count.index}"
  }
}

resource "aws_internet_gateway" "MyIgw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "Public_RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MyIgw.id
  }

  tags = {
    Name = "main"
  }
}

resource "aws_route_table_association" "Public_Route_Association" {
  count          = length(local.Mumbai_Azs)
  subnet_id      = local.pub_Subnets[count.index]
  route_table_id = aws_route_table.Public_RT.id
}
