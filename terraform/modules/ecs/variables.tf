variable "project" { type = string }
variable "vpc_id" { type = string }
variable "public_subnets" { type = list(string) }
variable "container_image" { type = string }
variable "aws_region" { type = string }
variable "alert_email" {
  description = "Email address subscribed to CloudWatch alarm notifications"
  type        = string
}
