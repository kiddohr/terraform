provider "aws" {
    region = "us-east-1"
}


variable "port" {
  default = 8080
}

resource "aws_security_group" "sg1" {
  name = "tfsg1"

  ingress = {
    from_port = variable.sg1
    to_port = variable.sg1
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "lc1" {
    image_id = "ami-020cba7c55df1f615"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.sg1]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello World" > index.xhtml
                nohup busybox httpd -f -p ${var.port} & 
                EOF 

    lifecycle {
      create_before_destroy = true
    }
}

data "aws_vpc" "default"{
    default = true
}

data "aws_subnets" "default" {

    filter {
        name = "vpc-id"
        values = [data.aws_vpc.default.id]
    }
  
}

resource "aws_autoscaling_group" "asg1" {
    launch_configuration = aws_launch_configuration.lc1.name
    vpc_zone_identifier = data.aws_subnets.default.ids
    
    min_size = 2
    max_size = 2

    tag  {
        key = "Name"
        value = "terraform-asg-example"
        propagate_at_launch = true
    } 
}