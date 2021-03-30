resource "aws_subnet" "Private" {
  count             = length(slice(local.Mumbai_Azs, 0, 2))
  vpc_id            = aws_vpc.myvpc.id
  availability_zone = local.Mumbai_Azs[count.index]
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + length(local.Mumbai_Azs))

  tags = {
    Name = "Private_Subnets-${count.index}"
  }
}

resource "aws_instance" "NatInstance" {
  ami                    = var.ami_id
  instance_type          = "t3.micro"
  subnet_id              = local.pub_Subnets[0]
  source_dest_check      = false
  vpc_security_group_ids = [aws_security_group.NAT_sg.id]


  tags = {
    Name = "NAT-Instance"
  }
}

resource "aws_security_group" "NAT_sg" {
  name        = "NAT_sg"
  description = "Allow traffic to access NAT Instance"
  vpc_id      = aws_vpc.myvpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "NAT_sg"
  }
}


resource "aws_route_table" "Private_RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.NatInstance.id
  }

  tags = {
    Name = "Private_RT"
  }
}

resource "aws_route_table_association" "Private_route_association" {
  count          = length(slice(local.Mumbai_Azs, 0, 2))
  subnet_id      = local.Private_Subnets[count.index]
  route_table_id = aws_route_table.Private_RT.id
}
