
data "aws_ssm_parameter" "vpc" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "public_subnet" {
  name = "/${var.project}/${var.environment}/public_subnet"
}

data "aws_ssm_parameter" "acm" {
  name = "/${var.project}/${var.environment}/acm"
}

data "aws_ssm_parameter" "Sg" {
   name = "/${var.project}/${var.environment}/alb"
}