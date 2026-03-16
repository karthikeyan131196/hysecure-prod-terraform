resource "aws_lb_target_group" "tg_https" {
  name        = "tg-https"
  port        = 443
  protocol    = "TCP"
  target_type = "ip"

  vpc_id = aws_vpc.hysecure_vpc.id

  health_check {
    protocol            = "HTTPS"
    path                = "/hapage.html"
    port                = "443"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
  }
  tags = merge(local.common_tags, {
    Name = "${var.project_name}-tg-https"
  })
}
resource "aws_lb_target_group" "tg_db" {
  name        = "tg-db"
  port        = 3306
  protocol    = "TCP"
  target_type = "ip"

  vpc_id = aws_vpc.hysecure_vpc.id

  health_check {
    protocol            = "HTTPS"
    path                = "/statuscheck"
    port                = "443"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
  }
    tags = merge(local.common_tags, {
    Name = "${var.project_name}-tg-db"
  })
}
resource "aws_lb_target_group" "tg_InfoAgent" {
  name        = "tg-infoagent"
  port        = 939
  protocol    = "TCP"
  target_type = "ip"

  vpc_id = aws_vpc.hysecure_vpc.id

  health_check {
    protocol            = "HTTPS"
    path                = "/statuscheck"
    port                = "443"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
  }
    tags = merge(local.common_tags, {
    Name = "${var.project_name}-tg-InfoAgent"
  })
}

# HTTPS - Active

resource "aws_lb_target_group_attachment" "active_https" {
  target_group_arn = aws_lb_target_group.tg_https.arn
  target_id        = aws_instance.active_node.private_ip
  port             = 443
}


# HTTPS - Standby

resource "aws_lb_target_group_attachment" "standby_https" {
  target_group_arn = aws_lb_target_group.tg_https.arn
  target_id        = aws_instance.standby_node.private_ip
  port             = 443
}

# HTTPS - Real-Node-1

resource "aws_lb_target_group_attachment" "realnode1_https" {
  target_group_arn = aws_lb_target_group.tg_https.arn
  target_id        = aws_instance.real_node.private_ip
  port             = 443
}

# Target for Internal-Communication

resource "aws_lb_target_group_attachment" "active_db" {
  target_group_arn = aws_lb_target_group.tg_db.arn
  target_id        = aws_instance.active_node.private_ip
  port             = 3306
}

resource "aws_lb_target_group_attachment" "standby_db" {
  target_group_arn = aws_lb_target_group.tg_db.arn
  target_id        = aws_instance.standby_node.private_ip
  port             = 3306
}
resource "aws_lb_target_group_attachment" "active_info" {
  target_group_arn = aws_lb_target_group.tg_InfoAgent.arn
  target_id        = aws_instance.active_node.private_ip
  port             = 939
}

resource "aws_lb_target_group_attachment" "standby_info" {
  target_group_arn = aws_lb_target_group.tg_InfoAgent.arn
  target_id        = aws_instance.standby_node.private_ip
  port             = 939
}