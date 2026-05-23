module "vpc" {
  source = "../../VPC-module"
  public_subnet = var.public_subnet
  private_subnet = var.private_subnet
  project = var.project
  environment = var.environment

  is_peering_required = true

}