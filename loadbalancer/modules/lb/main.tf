variable "sg_id" {}
variable "sn1_id" {}
variable "sn2_id" {}
variable "vpc_id" {}
variable "instance1_id" {}
variable "instance2_id" {}

resource "aws_lb" "mylb" {
  load_balancer_type = "application"
  security_groups = [var.sg_id]
  subnets = [var.sn1_id,var.sn2_id]
}

resource "aws_lb_target_group" "mytg" {
  port = 80
  protocol = "HTTP"

  vpc_id = var.vpc_id
}

resource "aws_lb_target_group_attachment" "tg-attach" {
  target_group_arn = aws_lb_target_group.mytg.arn
  target_id = var.instance1_id
  port = 80
}

resource "aws_lb_target_group_attachment" "tg-attach2" {
  target_group_arn = aws_lb_target_group.mytg.arn
  target_id = var.instance2_id
  port = 80
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.mylb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.mytg.arn
    type = "forward"
  }
}

output "loadbalancer" {
  value = aws_lb.mylb.dns_name
}