resource "aws_cloudwatch_log_group" "access_log" {
  name = "access.log"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "error_log" {
  name = "error.log"
  retention_in_days = 1
}
