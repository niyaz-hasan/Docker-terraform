resource "aws_lb_target_group" "this" {
  name     = var.name
  port     = var.port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
}

output "arn" {
  value = aws_lb_target_group.this.arn
}
