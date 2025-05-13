resource "aws_db_subnet_group" "this" {
  name       = "wordpress-db-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "WordPress DB Subnet Group"
  }
}

resource "aws_db_instance" "this" {
  identifier             = "wordpress-db"
  allocated_storage      = 20
  engine                 = "mariadb"
  engine_version         = "10.6"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids
  skip_final_snapshot    = true
  publicly_accessible    = false
  apply_immediately      = true
  multi_az               = false
  storage_encrypted      = false

  tags = {
    Name = "WordPress RDS"
  }
}