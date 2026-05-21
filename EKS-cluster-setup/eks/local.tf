locals {
  vpc_id = data.aws_ssm_parameter.vpc.value
  private = split (",", data.aws_ssm_parameter.private_subnet.value)
  cluster_sg = data.aws_ssm_parameter.control_plane.value
  eks_node = data.aws_ssm_parameter.eksnode.value

  common_tags = {
    project = var.project
    environment = var.environment
  }
}