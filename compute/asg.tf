resource "aws_autoscaling_group" "webservers_asg" {
  name                      = "AS-WebServers"
  max_size                  = 4
  min_size                  = 2
  desired_capacity          = 4
  vpc_zone_identifier       = ["subnet-17d7db5a", "subnet-45334a1a", "subnet-edb8c48b"]
  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.webserver_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "webserver-asg"
    propagate_at_launch = true
  }
}
