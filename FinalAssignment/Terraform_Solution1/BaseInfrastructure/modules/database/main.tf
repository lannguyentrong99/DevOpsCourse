provider "aws" {
  region = var.region
}

resource "aws_docdb_cluster_parameter_group" "test_parameter_group" {
  name        = "test-parameter-group"
  description = "Parameter group to disable TLS for MongoDB 5.0"
  family      = "docdb5.0"

  parameter {
    name  = "tls"
    value = "disabled"
  }
}

resource "aws_docdb_subnet_group" "test_subnet_group" {
  name       = "test-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "test_subnet_group"
  }
}

resource "aws_docdb_cluster" "test_cluster" {
  cluster_identifier      = "test-cluster"
  engine                  = "docdb"
  engine_version          = "5.0.0"
  master_username         = "myUsername"
  master_password         = "myPassword"
  db_subnet_group_name    = aws_docdb_subnet_group.test_subnet_group.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  skip_final_snapshot     = true
  apply_immediately       = true

  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.test_parameter_group.name

  tags = {
    Name = "test-cluster"
  }
}

resource "aws_docdb_cluster_instance" "test_cluster_instance" {
  count               = 1
  identifier          = "example-instance-${count.index}"
  cluster_identifier  = aws_docdb_cluster.test_cluster.id
  instance_class      = "db.t3.medium"

  apply_immediately = true

  tags = {
    Name = "test-cluster-instance"
  }
}