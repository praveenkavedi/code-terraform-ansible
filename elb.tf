resource "aws_elb" "web-cts-elb" {
  name = "web-cts-elb-${terraform.workspace}"
  //  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  subnets         = local.pub_Subnets
  security_groups = [aws_security_group.elb_sg.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  instances                   = aws_instance.web_Instance.*.id
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "Web-terraform-elb"
  }
}
