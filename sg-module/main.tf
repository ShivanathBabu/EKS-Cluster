resource "aws_security_group" "name" {
  name = "Eks-Cluster-sg"
  description = "Eks ports"
  vpc_id = var.vpc_id

  egress {
    from_port = "0"
    to_port = "0"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-eks_sg"
    }
  )


}