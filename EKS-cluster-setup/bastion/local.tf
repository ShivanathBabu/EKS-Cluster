locals {
  ami = data.aws_ami.example.id
  vpc_id = data.aws_ssm_parameter.vpc.id
  public_subnet = split(",", data.aws_ssm_parameter.public_subnet.value)[0]
  sg = data.aws_ssm_parameter.bastion.value

  common_tags = {
    project = var.project
    environment = var.environment
  }
}