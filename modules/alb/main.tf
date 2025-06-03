resource "aws_lb" "this" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = var.tg_arns[0]
  }
}



output "alb_dns_name" {
  value = aws_lb.this.dns_name
}
