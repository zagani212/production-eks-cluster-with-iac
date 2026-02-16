module "vpc" {
  source        = "./vpc"
  vpc_cidr      = var.vpc_cidr
  public_cidr1  = var.public_cidr1
  public_cidr2  = var.public_cidr2
  private_cidr1 = var.private_cidr1
  private_cidr2 = var.private_cidr2
}

module "iam" {
  source = "./iam"
}

module "eks" {
  source                               = "./eks"
  subnet_1                             = module.vpc.private_subnet_1
  subnet_2                             = module.vpc.private_subnet_2
  subnet_3                             = module.vpc.public_subnet_1
  subnet_4                             = module.vpc.public_subnet_2
  cluster_role_arn                     = module.iam.eks_role_arn
  cluster_AmazonEKSClusterPolicy       = module.iam.cluster_AmazonEKSClusterPolicy
  cluster_AmazonEKSComputePolicy       = module.iam.cluster_AmazonEKSComputePolicy
  cluster_AmazonEKSBlockStoragePolicy  = module.iam.cluster_AmazonEKSBlockStoragePolicy
  cluster_AmazonEKSLoadBalancingPolicy = module.iam.cluster_AmazonEKSLoadBalancingPolicy
  cluster_AmazonEKSNetworkingPolicy    = module.iam.cluster_AmazonEKSNetworkingPolicy
}

module "node_group" {
  source          = "./node_group"
  cluster         = module.eks.eks
  subnet_1        = module.vpc.private_subnet_1
  subnet_2        = module.vpc.private_subnet_2
  ami_type        = var.ami_type
  instance_types  = var.instance_types
  desired_size    = var.desired_size
  min_size        = var.min_size
  max_size        = var.max_size
  max_unavailable = var.max_unavailable
  node_role_arn   = module.iam.node_role_arn
}