locals {
  env_check = (terraform.workspace == "dev" ? 0 : 1)

  Mumbai_Azs = data.aws_availability_zones.MumbaiAZs.names

  pub_Subnets = aws_subnet.public.*.id

  Private_Subnets = aws_subnet.Private.*.id

  env_tags = {
    Environment = terraform.workspace
  }
  web_tags = merge(var.web_tags, local.env_tags)
}
