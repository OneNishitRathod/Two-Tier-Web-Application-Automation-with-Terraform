#  Define the provider
provider "aws" {
  region = "us-east-1"
}

# Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

#Calling Remote States on the Basis on Environments

data "terraform_remote_state" "network" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = "${var.env}-group12-finalproject"  // Bucket from where to GET Terraform State
    key    = "${var.env}-Network/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                            // Region where bucket created
  }
}


# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}


# Define tags locally
locals {
  default_tags = merge(module.globalvars.default_tags, { "env" = var.env })
  prefix       = module.globalvars.prefix
  name_prefix  = "${local.prefix}-${var.env}"
}

module "globalvars" {
  source = "../globalvars"
}

# Provision SSH key pair for Ubuntu and AmazonLinux VMs  2
resource "aws_key_pair" "linux_key" {
  key_name   = "linux_key-${var.env}"
  public_key = file(var.path_to_linux_key)
  tags = merge({
    Name = "${local.name_prefix}"
    },
    local.default_tags
  )
}

# Security Group for Bastion 
resource "aws_security_group" "SG_Bastion" {
  name        = "Allow_ssh-${var.env}"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id


  ingress {
    description = "SSH from everywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-SG_Bastion"
    }
  )
}

# Creating Bastion Server --1
resource "aws_instance" "Bastion_Server" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.linux_key.key_name
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_ids[0]
  security_groups             = [aws_security_group.SG_Bastion.id]
  associate_public_ip_address = true  #3 Changed its value to true after verfied.

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-Bastion_Server-${var.env}"
    }
  )
}



# Security Group For Web_Servers  
resource "aws_security_group" "SG_WebServer" {
  name        = "Allow_SSH_HTTP_NONPROD_SERVERS-${var.env}"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description      = "HTTP from everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

    ipv6_cidr_blocks = ["::/0"]
  }
  
  # addition of HTTPS
    ingress {
    description      = "HTTPS from everywhere"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH from everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    security_groups  = [aws_security_group.SG_Bastion.id]  ## change need to revert 
    
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-SG_WebServer-sg-${var.env}"
    }
  )
}



# Creating application load balancer
resource "aws_lb" "LoadBalancerApp" {
  name               = "LoadBalancerApp-${var.env}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.SG_WebServer.id]
  subnets            = data.terraform_remote_state.network.outputs.public_subnet_ids[*]
  enable_deletion_protection = false

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-LoadBalancerApp"
    }
  )
}

# Creating Target Group
resource "aws_lb_target_group" "targetgroup12" {
  name     = "targetgroup12-${var.env}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.network.outputs.vpc_id
  
  lifecycle { create_before_destroy = true }
# health check addition 
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 6
    timeout             = 30
    interval            = 31
  }
  
  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-targetgroup-${var.env}"
    }
  )
}


# Creating load balance listener
resource "aws_lb_listener" "LoadBalanceListner"{
  load_balancer_arn = aws_lb.LoadBalancerApp.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.targetgroup12.arn
  }
}


resource "aws_launch_configuration" "launch_configuration" {
  name          = "${local.name_prefix}-launch_configuration-${var.env}"
  image_id      = "ami-0c02fb55956c7d316"
  instance_type = var.instance_type
 security_groups    = [aws_security_group.SG_WebServer.id]
  key_name      = aws_key_pair.linux_key.key_name
  associate_public_ip_address = true
  iam_instance_profile = "LabInstanceProfile"

  user_data = templatefile("../../../Modules/Webserver-G12/install_httpd.sh.tpl",
      {
   
      env    = var.env
    }
    )
  lifecycle{
    create_before_destroy = true
  }

}

# Auto Scaling Group
resource "aws_autoscaling_group" "AutoScalingWebserver" {
  name               = "${local.name_prefix}-AutoScalingWebserver${var.env}"
   desired_capacity   = var.desired_capacity
  max_size           = var.maximum_size
  min_size           = var.minimum_size
  launch_configuration = aws_launch_configuration.launch_configuration.name
  vpc_zone_identifier       = data.terraform_remote_state.network.outputs.private_subnet_ids[*]
  depends_on = [aws_lb.LoadBalancerApp]
  target_group_arns = [aws_lb_target_group.targetgroup12.arn]
  health_check_type = "ELB"

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
    metrics_granularity = "1Minute"
    lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name-${var.env}"
    value               = "web"
    propagate_at_launch = true
  }
  
}


#Creating Scaling policy for AutoScaling Groupc combined CPU usage of all the instances reaches or greater  10% 
resource "aws_autoscaling_policy" "scalingpolicy10percent" {
  name                   = "${local.name_prefix}-scalingpolicy10percent-${var.env}"
  autoscaling_group_name = aws_autoscaling_group.AutoScalingWebserver.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 60
}


#Creating an alarm metric when combined CPU usage of all the instances  less then  or equal 5% 
resource "aws_cloudwatch_metric_alarm" "metricScalingPolicey5" {
  alarm_description   = "CPU usage of all the instances  less then  or equal 5% "
  alarm_actions       = [aws_autoscaling_policy.scalingpolicy5percent.arn]
  alarm_name          = "${local.name_prefix}_scale_down-${var.env}"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "5"
  evaluation_periods  = "2"
  period              = "60"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.AutoScalingWebserver.name
  }
}


#Creating Scaling policy for AutoScaling Groupc combined CPU usage of all the instances  less then  or equal 5% 
resource "aws_autoscaling_policy" "scalingpolicy5percent" {
  name                   = "${local.name_prefix}-scalingpolicy5percent-${var.env}"
  autoscaling_group_name = aws_autoscaling_group.AutoScalingWebserver.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 60
}


#Creating an alarm metric when combined CPU usage of all the instances  reaches or greater  10% 
resource "aws_cloudwatch_metric_alarm" "metricScalingPolicey10" {
  alarm_description   = " CPU usage of all the instances  reaches or greater  10%"
  alarm_actions       = [aws_autoscaling_policy.scalingpolicy5percent.arn]
  alarm_name          = "${local.name_prefix}_scale_up-${var.env}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "10"
  evaluation_periods  = "2"
  period              = "60"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.AutoScalingWebserver.name
  }
}

