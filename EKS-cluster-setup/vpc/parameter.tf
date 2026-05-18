resource "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
  type = "String"
  value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public" {
  name = "/${var.project}/${var.environment}/public_subnet"
  type = "StringList"
  value = join(",",module.vpc.public_subnet)
}

resource "aws_ssm_parameter" "private" {
  name = "/${var.project}/${var.environment}/private_subnet"
  type = "StringList"
  value = join(",",module.vpc.private_subnet)
}