resource "aws_db_subnet_group" "subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "mysql" {
  identifier         = var.name
  engine             = "mysql"
  instance_class     = "db.t3.micro"
  allocated_storage  = 20
  username           = var.db_username
  password           = var.db_password
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids = var.rds_security_group_ids
  skip_final_snapshot = true
}
