module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name    = "${var.project}-${var.environment}-alb"
  vpc_id  = local.vpc
  subnets = local.public_subnet
  internal = false 
  create_security_group = false
  security_groups = [local.sg]
  enable_deletion_protection = false
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-alb"
    }
  )
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = module.alb.arn
  port              = "443"
  protocol          = "HTTPS"

   ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.acm

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}

resource "aws_lb_target_group" "test" {
  name     = "${var.project}-${var.environment}-eks"
  port     = 80
  protocol = "HTTP"
  vpc_id   = local.vpc
  health_check {
    healthy_threshold = 2  // checks 2 times for consecutive health to be marked as healthy
    interval = 5   // send health check request for 5 seconds
    matcher = "200-299"  // any http response code between 200-299 consider successful
    path = "/"  // health path
    port = 8080 // health check performed on port number
    timeout = 2 // server as to resond within 2 seconds
    unhealthy_threshold = 3  // if target fails to check 3 times marked as unhealthy
  }
}

resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "teshome.online"
  type    = "A"

  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}
resource "aws_lb_listener_rule" "host_based_weighted_routing" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }

  condition {
    host_header {
      values = ["${var.environment}-${var.zone_name}"]
    }
  }
}




