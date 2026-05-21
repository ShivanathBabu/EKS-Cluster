locals {

 vpc = data.aws_ssm_parameter.vpc.value
 public_subnet = split(",", data.aws_ssm_parameter.public_subnet.value)
 acm = data.aws_ssm_parameter.acm.value
 sg = data.aws_ssm_parameter.Sg.value

 common_tags = {
    project = var.project
    environment = var.environment
  }

}