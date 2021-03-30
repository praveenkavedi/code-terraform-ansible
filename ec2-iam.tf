data "template_file" "s3_role_policy" {
  template = file("scripts/web-ec2-policy.json")
  vars = {
    s3_bucket_arn = "arn:aws:s3:::var.s3_bucket_name/*"
  }
}


resource "aws_iam_role_policy" "s3_web_role_policy" {
  name = "s3_web_role_policy"
  role = aws_iam_role.s3_web_role.id
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = data.template_file.s3_role_policy.rendered
}

resource "aws_iam_role" "s3_web_role" {
  name = "s3_web_role"

  assume_role_policy = file("scripts/web-ec2-assume-role.json")
}


resource "aws_iam_instance_profile" "ec2-iam-instance-profile" {
  name = "ec2-iam-instance-profile"
  role = aws_iam_role.s3_web_role.name
}
