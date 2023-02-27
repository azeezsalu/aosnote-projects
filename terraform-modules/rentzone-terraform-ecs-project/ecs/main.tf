# create ecs cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${}-${}-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

# create cloudwatch log group
resource "aws_cloudwatch_log_group" "log_group" {
  name = "/ecs/${}-${}-td"

  lifecycle {
    create_before_destroy = 
  }
}

# create task definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${}-${}-td"
  execution_role_arn       = 
  network_mode             = 
  requires_compatibilities = 
  cpu                      = 
  memory                   = 

  runtime_platform {
    operating_system_family = 
    cpu_architecture        = 
  }

  # create container definition
  container_definitions = jsonencode([
    {
      name      = "${}-${}-container"
      image     = "${}"
      essential = 

      portMappings = [
        {
          containerPort = 
          hostPort      = 
        }
      ]

      environmentFiles = [
        {
          value = "arn:aws:s3:::${}-${}/${}"
          type  = "s3"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = "${}",
          "awslogs-region"        = "${}",
          "awslogs-stream-prefix" = 
        }
      }
    }
  ])
}

# create ecs service
resource "aws_ecs_service" "ecs_service" {
  name                               = "${}-${}-service"
  launch_type                        = 
  cluster                            = 
  task_definition                    = 
  platform_version                   = 
  desired_count                      = 
  deployment_minimum_healthy_percent = 
  deployment_maximum_percent         = 

  # task tagging configuration
  enable_ecs_managed_tags = 
  propagate_tags          = 

  # vpc and security groups
  network_configuration {
    subnets          = 
    security_groups  = 
    assign_public_ip = 
  }

  # load balancing
  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "${}-${}-container"
    container_port   = 
  }
}