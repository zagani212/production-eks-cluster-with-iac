resource "aws_eks_cluster" "cluster" {
  name = "k8s_cluster"

  access_config {
    authentication_mode = "API"
  }

  role_arn = var.cluster_role_arn
  version  = "1.31"

  bootstrap_self_managed_addons = false

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true

    subnet_ids = [
      var.subnet_1,
      var.subnet_2,
      var.subnet_3,
      var.subnet_4,
    ]
  }
  depends_on = [
    var.cluster_AmazonEKSClusterPolicy,
    var.cluster_AmazonEKSComputePolicy,
    var.cluster_AmazonEKSBlockStoragePolicy,
    var.cluster_AmazonEKSLoadBalancingPolicy,
    var.cluster_AmazonEKSNetworkingPolicy,
  ]
}