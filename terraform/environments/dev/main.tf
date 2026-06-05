terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source             = "../../modules/vpc"
  project            = var.project
  cidr               = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones = ["${var.aws_region}a", "${var.aws_region}b"]
}

module "ecs" {
  source           = "../../modules/ecs"
  project          = var.project
  vpc_id           = module.vpc.vpc_id
  public_subnets   = module.vpc.public_subnets
  container_image  = var.container_image
  aws_region       = var.aws_region
}
