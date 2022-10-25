resource "aws_db_subnet_group" "project_db_sub_group" {
  name       = "main"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]

  tags = {
    Name = "DB subnet group for RDS"
  }
}

resource "aws_elasticache_subnet_group" "project_ec_sub_group" {
  name       = "main"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]

  tags = {
    Name = "Subnet group for ECache"
  }
}


resource "aws_db_instance" "project_rds" {
  allocated_storage      = 10
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_name                   = var.db_name
  username               = var.db_user
  password               = var.db_pass
  parameter_group_name   = "default.mysql5.7"
  multi_az               = false
  publicly_accessible    = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.project_db_sub_group.name
  vpc_security_group_ids = [aws_security_group.project_backend_sg.id]
}

resource "aws_elasticache_cluster" "project_cache" {
  cluster_id           = "project-cache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  security_group_ids   = [aws_security_group.project_backend_sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.project_ec_sub_group.name
}

resource "aws_mq_broker" "project-rmq" {
  broker_name        = "project-rmq"
  engine_type        = "ActiveMQ"
  engine_version     = "5.15.0"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.project_backend_sg.id]
  subnet_ids         = [module.vpc.private_subnets[0]]

  user {
    username = var.rmq_user
    password = var.rmq_pass
  }
}