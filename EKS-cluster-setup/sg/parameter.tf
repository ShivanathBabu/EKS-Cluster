resource "aws_ssm_parameter" "bastion" {
  name = "/${var.project}/${var.environment}/bastion"
  type = "String"
  value = module.Bastion.sg_id
}

resource "aws_ssm_parameter" "ekscluster" {
  name = "/${var.project}/${var.environment}/ekscluster"
  type = "String"
  value = module.cluster.sg_id
}

resource "aws_ssm_parameter" "eksnode" {
  name = "/${var.project}/${var.environment}/eksnode"
  type = "String"
  value = module.node.sg_id
}

resource "aws_ssm_parameter" "sg" {
  name = "/${var.project}/${var.environment}/alb"
  type = "String"
  value = module.ingress.sg_id
}

