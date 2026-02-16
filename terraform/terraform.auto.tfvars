# VPC variables
vpc_cidr      = "10.0.0.0/16"
public_cidr1  = "10.0.1.0/24"
public_cidr2  = "10.0.2.0/24"
private_cidr1 = "10.0.3.0/24"
private_cidr2 = "10.0.4.0/24"


# Node Group
ami_type        = "AL2_x86_64"
instance_types  = ["t3.micro"]
desired_size    = 2
min_size        = 1
max_size        = 5
max_unavailable = 1