resource "aws_ssm_parameter" "name" {
  name = "/${var.project}/${var.environment}/acm"
  type = "String"
  value = aws_acm_certificate.cert.arn
}