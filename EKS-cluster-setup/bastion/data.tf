data "aws_ami" "example" {
  most_recent      = true
  owners           = [973714476881]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "vpc" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "public_subnet" {
  name = "/${var.project}/${var.environment}/public_subnet"
}

data "aws_ssm_parameter" "bastion" {
  name = "/${var.project}/${var.environment}/bastion"
}