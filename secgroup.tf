resource "aws_security_group" "project_lb_sg" {
  name        = "project_lb_sg"
  description = "Sec group for elb"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "project_bastion_sg" {
  name        = "bastion_sg"
  description = "Sec group for bastion ec2 instances"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = [var.my_ip]
  }

}

resource "aws_security_group" "project_prod_sg" {
  name        = "project_prod_sg"
  description = "Sec group for beanstalk instances"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
    security_groups = [aws_security_group.project_bastion_sg.id]
  }
}

resource "aws_security_group" "project_backend_sg" {
  name        = "project_backend_sg"
  description = "Sec group for RDS, MQ, Elasticache"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
    security_groups = [aws_security_group.project_prod_sg.id]
  }

}


resource "aws_security_group_rule" "example" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.project_backend_sg.id
  source_security_group_id = aws_security_group.project_backend_sg.id
}