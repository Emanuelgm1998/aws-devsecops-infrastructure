output "app_url" {
  value = "http://${module.ecs.alb_dns}"
}
