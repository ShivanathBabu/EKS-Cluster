locals {
  vpc_id = data.aws_ssm_parameter.vpc.id
  private = data.aws_ssm_parameter.private_subnet.id
  cluster_sg = data.aws_ssm_parameter.control_plane.id
  eks_node = data.aws_ssm_parameter.node.id

  common_tags = {
    project = var.project
    environment = var.environment
  }
}