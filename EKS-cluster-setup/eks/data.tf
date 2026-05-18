data "aws_ssm_parameter" "private_subnet" {
  name = "/${var.project}/${var.environment}/private_subnet"
}

data "aws_ssm_parameter" "vpc" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "control_plane" {
  name = "/${var.project}/${var.environment}/ekscluster"
}

data "aws_ssm_parameter" "node" {
  name = "/${var.project}/${var.environment}/eksnode"
}