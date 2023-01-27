# create an auto scaling group for the ecs service
resource "aws_appautoscaling_target" "ecs_asg" {
  max_capacity       = 
  min_capacity       = 
  resource_id        = "service/<ecs-cluster-name>/<ecs-service-name>"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = 

  depends_on = 
}

# create scaling policy for the auto scaling group
resource "aws_appautoscaling_policy" "ecs_policy" {
  name               = 
  policy_type        = "TargetTrackingScaling"
  resource_id        = "service/<ecs-cluster-name>/<ecs-service-name>"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = 
  
  target_tracking_scaling_policy_configuration {

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 
    scale_out_cooldown = 
    scale_in_cooldown  = 
    disable_scale_in   = 
  }

  depends_on = 
}