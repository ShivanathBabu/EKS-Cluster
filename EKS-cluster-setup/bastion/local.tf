locals {
  ami = data.aws_ami.example.id
  vpc_id = data.aws_ssm_parameter.vpc.id
  subnet = data.aws_ssm_parameter.public_subnet.id
  sg = data.aws_ssm_parameter.bastion.id
}