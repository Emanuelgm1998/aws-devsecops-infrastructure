resource "aws_secretsmanager_secret" "app" {
  name                    = "${var.project}/app-secrets"
  recovery_window_in_days = 0
  tags = { Name = "${var.project}-secrets" }
}

resource "aws_secretsmanager_secret_version" "app" {
  secret_id = aws_secretsmanager_secret.app.id
  secret_string = jsonencode({
    DB_PASSWORD = "secure-placeholder-password"
    API_KEY     = "secure-placeholder-api-key"
  })
}
