# create an auto scaling group for the ecs service
resource "aws_appautoscaling_target" "ecs_asg" {
  max_capacity       = 
  min_capacity       = 
  resource_id        = "service/${}-${}-cluster/${}-${}-service"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  depends_on = 
}

# create scaling policy for the auto scaling group
resource "aws_appautoscaling_policy" "ecs_policy" {
  name               = "${}-${}-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "service/${}-${}-cluster/${}-${}-service"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  
  target_tracking_scaling_policy_configuration {

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 70
    scale_out_cooldown = 300
    scale_in_cooldown  = 300
    disable_scale_in   = false 
  }

  depends_on = 
}