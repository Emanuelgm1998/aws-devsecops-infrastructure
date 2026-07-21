variable "aws_region" { default = "us-east-1" }
variable "project" { default = "secure-saas" }
variable "container_image" { default = "cloudz777/secure-saas-platform:latest" }
variable "alert_email" {
  description = "Email address that receives CloudWatch alarm notifications"
  type        = string
}
