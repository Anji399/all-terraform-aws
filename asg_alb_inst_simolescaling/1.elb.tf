resource "aws_lb" "my-elb" {
  name               = "my-elb"
  internal           = false
  load_balancer_type = "application"
  subnets = ["${aws_subnet.main-public-1.id}", "${aws_subnet.main-public-2.id}"]
  security_groups = ["${aws_security_group.elb-securitygroup.id}"]
}

resource "aws_lb_listener" "my-list" {
  load_balancer_arn = aws_lb.my-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-tg.arn
  }
}


resource "aws_lb_target_group" "my-tg" {
   name     = "learn-asg"
   port     = 80
   protocol = "HTTP"
   vpc_id   = aws_vpc.main.id
 }

resource "aws_autoscaling_attachment" "my-att" {
  autoscaling_group_name = aws_autoscaling_group.example-autoscaling.id
  alb_target_group_arn   = aws_lb_target_group.my-tg.arn
}


