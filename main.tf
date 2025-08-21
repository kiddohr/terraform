provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "example" {
    name = "terraformexample"

    ingress = {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_instance" "fromTerraform" {
    ami = "ami-020cba7c55df1f615"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.example.id]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" >index.xhtml
                nohup busybox httpd -f -p 8080 &
                EOF
    
    user_data_replace_on_change = true

    tags = {
        name = "from-terraform"
    }

}