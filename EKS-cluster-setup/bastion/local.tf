locals {
  ami = data.aws_ami.example.id
  vpc_id = data.aws_ssm_parameter.vpc.id
  subnet = split(",", data.aws_ssm_parameter.public_subnet.id.value)[0]
  sg = data.aws_ssm_parameter.bastion.id

  common_tags = {
    project = var.project
    environment = var.environment
  }
}