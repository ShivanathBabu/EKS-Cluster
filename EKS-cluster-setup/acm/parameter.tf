resource "aws_ssm_parameter" "name" {
  name = "/${var.project}/${var.environment}/ekscluster"
  type = "String"
  value = aws_acm_certificate.cert.arn
}