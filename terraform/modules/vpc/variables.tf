variable "project"            { type = string }
variable "cidr"               { type = string }
variable "public_subnets"     { type = list(string) }
variable "availability_zones" { type = list(string) }
