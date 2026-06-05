variable "project"         { type = string }
variable "vpc_id"          { type = string }
variable "public_subnets"  { type = list(string) }
variable "container_image" { type = string }
variable "aws_region"      { type = string }
