resource "aws_security_group" "alb-sg" {
  name        = "alb"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.dev-vpc.id

  ingress {
    description      = "enduser port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}

resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = aws_subnet.pubsubnet.*.id

  enable_deletion_protection = true

  tags = {
    Name = "alb"
  }
}

resource "aws_lb_target_group" "tomcat-tg" {
  name     = "tomcat-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.dev-vpc.id
}


resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.tomcat-tg.arn
  target_id        = aws_instance.tomcat.id
  port             = 8080
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tomcat-tg.arn
  }
}
