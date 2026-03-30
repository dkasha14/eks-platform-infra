resource "aws_ecr_repository" "eks_app_repository" {
 name = "${var.environment}-${var.repository_name}"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "${var.environment}-eks-app"
    Environment = var.environment
  }
}
