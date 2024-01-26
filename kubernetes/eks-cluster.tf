module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name                  = "myAppp-eks-cluster"  
  cluster_version               = "1.24"
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns   = { most_recent = true }
    kube-proxy = { most_recent = true }
    vpc-cni    = { most_recent = true }

  }

  vpc_id                   = module.myAppp-vpc.vpc_id
  subnet_ids               = module.myAppp-vpc.private_subnets
  control_plane_subnet_ids = module.myAppp-vpc.public_subnets

  eks_managed_node_groups = {
    blue = {}
    dev = { min_size = 1, max_size = 6, desired_size = 3, instance_types = ["t2.medium"], capacity_type = "SPOT" }
  }

  
  fargate_profiles = { default = { name = "default", selectors = [{ namespace = "default" }] } }

  manage_aws_auth_configmap = true

  aws_auth_roles = [{ rolearn = "arn:aws:iam::66666666666:role/role1", username = "role1", groups = ["system:masters"] }]

  aws_auth_users = [
    { userarn = "arn:aws:iam::66666666666:user/user1", username = "user1", groups = ["system:masters"] },
    { userarn = "arn:aws:iam::66666666666:user/user2", username = "user2", groups = ["system:masters"] },
  ]

  aws_auth_accounts = ["777777777777", "888888888888"]

  tags = { Environment = "dev", Terraform = "true" }
}
