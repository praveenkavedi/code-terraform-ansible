
resource "aws_instance" "web_Instance" {
  count                  = var.web_ins_count
  ami                    = var.web_amis[var.region]
  instance_type          = var.Instance_type
  subnet_id              = local.pub_Subnets[count.index]
  user_data              = file("scripts/apache.sh")
  iam_instance_profile   = aws_iam_instance_profile.ec2-iam-instance-profile.name
  vpc_security_group_ids = [aws_security_group.Web_sg.id]

  tags = {
    Name = "Web-Instance-dev"
  }
}
