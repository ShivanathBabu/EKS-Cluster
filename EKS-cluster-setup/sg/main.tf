module "ingress" {
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


resource "aws_security_group_rule" "Bastion_node" {
  type = "ingress"
  from_port = "22"
  to_port = "22"
  protocol = "TCP"
  source_security_group_id = module.Bastion.sg_id 
  security_group_id = module.node.sg_id 
}

resource "aws_security_group_rule" "laptop_bastion" {
  type = "ingress"
  from_port = "22"
  to_port = "22"
  protocol = "TCP"
  source_security_group_id = ["0.0.0.0/0"]
  security_group_id = module.Bastion.sg_id  
}

resource "aws_security_group_rule" "bastion_cluster" {
  type = "ingress"
  from_port = "443"
  to_port = "443"
  protocol = "TCP"
  source_security_group_id = module.Bastion.sg_id 
  security_group_id = module.cluster.sg_id
}

resource "aws_security_group_rule" "cluster_node" {
  type = "ingress"
  from_port = "0"
  to_port = "0"
  protocol = "TCP"
  source_security_group_id = module.cluster.sg_id 
  security_group_id = module.node.sg_id  
}

resource "aws_security_group_rule" "node_cluster" {
  type = "ingress"
  from_port = "0"
  to_port = "0"
  protocol = "TCP"
  source_security_group_id = module.node.sg_id
  security_group_id = module.cluster.sg_id
}

resource "aws_security_group_rule" "https_ingress" {
  type = "ingress"
  from_port = "443"
  to_port = "443"
  protocol = "TCP"
  source_security_group_id = ["0.0.0.0/0"]
  security_group_id = module.ingress.sg_id 
}

resource "aws_security_group_rule" "ingress_node" {
  type = "ingress"
  from_port = "443"
  to_port = "443"
  protocol = "TCP"
  source_security_group_id = module.ingress.sg_id     
  security_group_id = module.node.sg_id 
}
# Worker nodes can communicate with each other
# Pods can communicate across nodes
# Cluster internal traffic works properly
# Control plane or internal services can access nodes
# Allow all internal VPC traffic to EKS nodes
resource "aws_security_group_rule" "eks_node_vpc" {
  type = "ingress"
  from_port = "0"
  to_port = "0"
  protocol = "-1"
  source_security_group_id = ["10.0.0.0/16"]
  security_group_id = module.node.sg_id 
}