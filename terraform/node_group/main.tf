resource "aws_eks_node_group" "node_group" {
  cluster_name    = var.cluster
  node_group_name = "node_group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = [var.subnet_1, var.subnet_2]

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  ami_type       = var.ami_type
  instance_types = var.instance_types

  update_config {
    max_unavailable = var.max_unavailable
  }

}