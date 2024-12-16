module "eks" {
  source             = "../../modules/eks"
  cluster_name       = var.cluster_name
  vpc_cidr           = var.vpc_cidr
  subnet_cidrs       = var.subnet_cidrs
  availability_zones = var.availability_zones
}