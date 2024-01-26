provider "aws" {
  region = "us-east-1"
}

variable "vpc_cidr_block" {}
variable "private_subnet_cidr_blocks" {}
variable "public_subnet_cidr_blocks" {}

data "aws_availability_zones" "available" {}

module "myAppp-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name                 = "myAppp-vpc"
  cidr                 = var.vpc_cidr_block
  private_subnets      = var.private_subnet_cidr_blocks
  public_subnets       = var.public_subnet_cidr_blocks
  azs                  = data.aws_availability_zones.available.names
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/myAppp-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/myAppp-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                    = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/myAppp-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"           = 1
  }
}

resource "aws_lb" "myAppp-alb" {
  name               = "myAppp-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.myAppp-vpc.default_security_group_id]

  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true
  enable_http2                    = true
  idle_timeout                    = 60

  subnets = module.myAppp-vpc.public_subnets
}

resource "aws_lb_target_group" "myAppp-target-group" {
  name     = "myAppp-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.myAppp-vpc.vpc_id
}

resource "aws_lb_listener" "myAppp-listener" {
  load_balancer_arn = aws_lb.myAppp-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "OK"
    }
  }
}
