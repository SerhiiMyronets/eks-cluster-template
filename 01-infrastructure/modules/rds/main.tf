resource "aws_db_subnet_group" "this" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "${var.identifier}-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier             = var.identifier
  db_name                = var.rds_config.db_name
  username               = var.rds_config.db_username
  password               = random_password.db_password.result
  engine                 = var.rds_config.engine
  engine_version         = var.rds_config.engine_version
  instance_class         = var.rds_config.instance_class
  allocated_storage      = var.rds_config.allocated_storage
  db_subnet_group_name   = aws_db_subnet_group.this.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.this.id]

  tags = {
    Name = var.identifier
  }
}

resource "aws_security_group" "this" {
  name        = "${var.identifier}-sg"
  description = "Allow DB access from allowed sources"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.identifier}-sg"
  }
}

resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = var.rds_config.port
  to_port           = var.rds_config.port
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  cidr_blocks       = var.private_subnet_cidrs
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/${var.identifier}/db-password"
  type  = "SecureString"
  value = random_password.db_password.result
}

resource "aws_ssm_parameter" "db_username" {
  name  = "/${var.identifier}/db-username"
  type  = "String"
  value = var.rds_config.db_username
}

resource "aws_ssm_parameter" "db_host" {
  name  = "/${var.identifier}/db-host"
  type  = "String"
  value = aws_db_instance.this.address
}

resource "random_password" "db_password" {
  length  = 16
  special = true

  override_special = "!#$%^&*()-_+=<>?~"
}