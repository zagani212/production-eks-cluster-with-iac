output "eks_role_arn" {
  value = aws_iam_role.cluster.arn
}

output "node_role_arn" {
  value = aws_iam_role.node.arn
}

output "cluster_AmazonEKSClusterPolicy" {
  value = aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
}
output "cluster_AmazonEKSComputePolicy" {
  value = aws_iam_role_policy_attachment.cluster_AmazonEKSComputePolicy
}
output "cluster_AmazonEKSBlockStoragePolicy" {
  value = aws_iam_role_policy_attachment.cluster_AmazonEKSBlockStoragePolicy
}
output "cluster_AmazonEKSLoadBalancingPolicy" {
  value = aws_iam_role_policy_attachment.cluster_AmazonEKSLoadBalancingPolicy
}
output "cluster_AmazonEKSNetworkingPolicy" {
  value = aws_iam_role_policy_attachment.cluster_AmazonEKSNetworkingPolicy
}