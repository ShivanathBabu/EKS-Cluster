module "front_alb" {
  source = "../../sg-module"
  vpc_id = local.vpc_id
  sg_name = "frontend-alb"
  sg_description = "allow-alb"
  project = var.project
  environment = var.environment
}

module "Bastion" {
  source = "../../sg-module"
  vpc_id = local.vpc_id
  sg_name = "Bastion"
  sg_description = "allow-Bastion"
  project = var.project
  environment = var.environment
}

module "VPN" {
  source = "../../sg-module"
  vpc_id = local.vpc_id
  sg_name = "VPN"
  sg_description = "allow-VPN"
  project = var.project
  environment = var.environment
}

module "cluster" {
  source = "../../sg-module"
  vpc_id = local.vpc_id
  sg_name = "cluster"
  sg_description = "allow-cluster"
  project = var.project
  environment = var.environment
}

module "node" {
  source = "../../sg-module"
  vpc_id = local.vpc_id
  sg_name = "node"
  sg_description = "allow-node"
  project = var.project
  environment = var.environment
}