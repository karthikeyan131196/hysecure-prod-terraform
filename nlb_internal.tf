############################################
# Internal Network Load Balancer
############################################

resource "aws_lb" "internal_nlb" {
  name               = "hysecure-internal-nlb"
  internal           = true
  load_balancer_type = "network"
  ip_address_type    = "ipv4"

  subnets = [
    aws_subnet.az1a.id,
    aws_subnet.az1b.id
  ]

  enable_cross_zone_load_balancing = true

  tags = {
    Name = "hysecure-internal-nlb"
  }
}

############################################
# Listener - Database (3306)
############################################

resource "aws_lb_listener" "listener_db" {
  load_balancer_arn = aws_lb.internal_nlb.arn
  port              = 3306
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_db.arn
  }
}

############################################
# Listener - Info Agent (939)
############################################

resource "aws_lb_listener" "listener_info" {
  load_balancer_arn = aws_lb.internal_nlb.arn
  port              = 939
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_InfoAgent.arn
  }
}
