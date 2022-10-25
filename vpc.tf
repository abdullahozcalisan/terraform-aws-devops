module "vpc" {

  source               = "terraform-aws-modules/vpc/aws"
  version              = "3.18.0"
  name                 = var.vpc_name
  cidr                 = var.vpc_cidr
  azs                  = [var.zone1, var.zone2, var.zone3]
  private_subnets      = [var.priv_sub1_cidr, var.priv_sub2_cidr, var.priv_sub3_cidr]
  public_subnets       = [var.pub_sub1_cidr, var.pub_sub2_cidr, var.pub_sub3_cidr]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Terraform = true
    env       = "prod"
  }
  vpc_tags = {
    Name = var.vpc_name
  }


}