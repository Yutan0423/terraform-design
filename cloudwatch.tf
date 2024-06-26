resource "aws_cloudwatch_log_group" "for_ecs" {
  name              = "/ecs/default"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "for_ecs_scheduled_tasks" {
  name              = "/ecs-scheduled-tasks/default"
  retention_in_days = 30
}

resource "aws_cloudwatch_event_rule" "default_batch" {
  name                = "default-batch"
  description         = "とても重要なバッチ処理です"
  schedule_expression = "cron(*/2 * * * ? *)"
}

resource "aws_cloudwatch_event_target" "default_batch" {
  target_id = "default-batch"
  rule      = aws_cloudwatch_event_rule.default_batch.name
  role_arn  = module.ecs_events_role.iam_role_arn
  arn       = aws_ecs_cluster.default.arn
  ecs_target {
    launch_type         = "FARGATE"
    task_count          = 1
    platform_version    = "1.4.0"
    task_definition_arn = aws_ecs_task_definition.default_batch.arn
    network_configuration {
      assign_public_ip = "false"
      subnets          = [aws_subnet.private_1.id]
    }
  }
}
