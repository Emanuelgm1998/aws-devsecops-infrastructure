resource "aws_sns_topic" "alerts" {
  name = "${var.project}-alerts"

  tags = {
    Name = "${var.project}-alerts"
  }
}

resource "aws_sns_topic_subscription" "alerts_email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}
