resource "aws_iam_role" "node" {
  name =  "${var.prefix}-${var.cluster_name}-role-node"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  POLICY
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.node.name
}


// It will create a node group in eks with 2 machines. The machines will be t3.medium
// because it is the default specified by AWS. Instance types will change this to t2.micro
resource "aws_eks_node_group" "node-1" {
  cluster_name = aws_eks_cluster.cluster.name
  node_group_name = "node-1"
  node_role_arn = aws_iam_role.node.arn
  subnet_ids = aws_subnet.subnets[*].id
  instance_types = ["t2.micro"]
  scaling_config {
    desired_size = var.desired_nodes_scalling_size
    max_size = var.desired_nodes_scalling_max_size
    min_size = var.desired_nodes_scalling_min_size
  }
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_eks_node_group" "node-2" {
  cluster_name = aws_eks_cluster.cluster.name
  node_group_name = "node-2"
  node_role_arn = aws_iam_role.node.arn
  subnet_ids = aws_subnet.subnets[*].id
  instance_types = ["t2.micro"]
  scaling_config {
    desired_size = var.desired_nodes_scalling_size
    max_size = var.desired_nodes_scalling_max_size
    min_size = var.desired_nodes_scalling_min_size
  }
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}