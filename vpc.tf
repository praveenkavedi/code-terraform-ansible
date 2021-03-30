resource "aws_vpc" "myvpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.tenancy


  tags = {
    Name        = "CTS_Myvpc"
    Environment = terraform.workspace
  }
}
