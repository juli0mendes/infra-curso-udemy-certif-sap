resource "aws_launch_template" "webserver_lt" {
  name_prefix   = "webserver-"
  image_id      = "ami-0c765d44cf1f25d26"
  instance_type = "t2.micro"
  key_name      = "ec2-webserver"
  user_data     = base64encode(file("${path.module}/scripts/init.sh"))

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.webserver_sg.id]
    subnet_id                   = "subnet-17d7db5a"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "webserver-asg"
    }
  }
}
