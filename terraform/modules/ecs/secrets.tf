resource "random_password" "db_password" {
  length  = 24
  special = true
}

resource "random_password" "api_key" {
  length  = 24
  special = true
}

resource "aws_secretsmanager_secret" "app" {
  name                    = "${var.project}/app-secrets"
  recovery_window_in_days = 0
  tags                    = { Name = "${var.project}-secrets" }
}

resource "aws_secretsmanager_secret_version" "app" {
  secret_id = aws_secretsmanager_secret.app.id
  secret_string = jsonencode({
    DB_PASSWORD = random_password.db_password.result
    API_KEY     = random_password.api_key.result
  })
}
