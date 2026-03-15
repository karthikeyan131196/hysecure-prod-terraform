
# Generate SSH Private Key

resource "tls_private_key" "hysecure_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "hysecure_pem" {
  content         = tls_private_key.hysecure_key.private_key_pem
  filename        = "${path.module}/hysecure-key.pem"
  file_permission = "0400"
}

# AWS Key Pair

resource "aws_key_pair" "hysecure_key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.hysecure_key.public_key_openssh
}
resource "aws_instance" "active_node" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = local.subnet_by_az[var.instance_az_map["active"]]
  vpc_security_group_ids      = [aws_security_group.hysecure_sg.id]

  key_name                    = var.key_pair_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-active"
    Role = "Active"
  })

  depends_on = [aws_key_pair.hysecure_key]
}
resource "aws_instance" "standby_node" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = local.subnet_by_az[var.instance_az_map["standby"]]
  vpc_security_group_ids      = [aws_security_group.hysecure_sg.id]

  key_name                    = var.key_pair_name
  associate_public_ip_address = false

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-standby"
    Role = "Standby"
  })

  depends_on = [aws_key_pair.hysecure_key]
}
resource "aws_instance" "real_node" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = local.subnet_by_az[var.instance_az_map["active"]]
  vpc_security_group_ids      = [aws_security_group.hysecure_sg.id]

  key_name                    = var.key_pair_name
  associate_public_ip_address = false

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-real"
    Role = "Real"
  })

  depends_on = [aws_key_pair.hysecure_key]
}
