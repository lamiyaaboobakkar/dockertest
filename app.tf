# app


resource "aws_ecs_task_definition" "myapp-task-definition" {
  family                = "myapp"
  container_definitions =  file("task-definitions/service.json")
}


resource "aws_ecs_service" "myapp-service" {
  name            = "myapp"
  cluster         = aws_ecs_cluster.example-cluster.id
  task_definition = aws_ecs_task_definition.myapp-task-definition.arn
  desired_count   = 1
  #iam_role        = aws_iam_role.ecs-service-role.arn
  depends_on      = [aws_iam_policy_attachment.ecs-service-attach1]

 
 
}
