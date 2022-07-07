provider "aws" {
  region = "us-east-1"
}

resource "aws_redshift_cluster" "example" {
  cluster_identifier = var.clusterid
  database_name      = var.dbname
  master_username    = var.master_username
  master_password    = var.master_password
  node_type          = "dc2.large"
  cluster_type       = "single-node"
}

resource "aws_iam_role" "test_role" {
  name = var.rolename

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_redshift_cluster_iam_roles" "example" {
  cluster_identifier = aws_redshift_cluster.example.cluster_identifier
  iam_role_arns      = [aws_iam_role.test_role.arn]
}

#resource "aws_redshift_security_group" "default" {
 # name = "redshift-sg"
  #description = "Allow Databases traffic"
  #subnet_ids  = ["${aws_subnet.main.id}"]

  #ingress {
   # cidr = "10.0.0.0/24"
 # }
#}
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}