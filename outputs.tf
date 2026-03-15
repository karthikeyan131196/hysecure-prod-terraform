output "vpc_id" {
  value = aws_vpc.hysecure_vpc.id
}

output "subnet_ids" {
  value = [
    aws_subnet.az1a.id,
    aws_subnet.az1b.id
  ]
}

output "security_group_id" {
  value = aws_security_group.hysecure_sg.id
}

output "instance_ids" {
  value = {
    active  = aws_instance.active_node.id
    standby = aws_instance.standby_node.id
    real    = aws_instance.real_node.id
  }
}

output "private_ips" {
  value = {
    active  = aws_instance.active_node.private_ip
    standby = aws_instance.standby_node.private_ip
    real    = aws_instance.real_node.private_ip
  }
}
output "private_key_location" {
  value = "hysecure-key.pem created in Terraform folder"
}
output "vip_ips_by_az" {
  description = "VIP private IP mapped to Availability Zone"

  value = {
    (aws_subnet.az1a.availability_zone) = aws_network_interface.vip_az1a.private_ip
    (aws_subnet.az1b.availability_zone) = aws_network_interface.vip_az1b.private_ip
  }
}
output "internal_nlb_by_az" {
  description = "Internal NLB DNS and IP per AZ"

  value = {
    dns_name = aws_lb.internal_nlb.dns_name

  }
}
output "external_nlb_by_az" {
  description = "External NLB DNS and IP per AZ"

  value = {
    dns_name = aws_lb.external_nlb.dns_name

  }
}
