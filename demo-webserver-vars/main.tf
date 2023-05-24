provider "aws" {
    region = "us-east-1"
  
}

resource "aws_security_group" "http_instance" {

    name = "terraform-demo-security"
    ingress {
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_instance" "demo-webser" {
    ami = "ami-0889a44b331db0194"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.http_instance.id}"]
    user_data =  <<-EOF
	      #!/bin/bash
	      echo "Hello, World" > index.html
	      nohup busybox httpd -f -p "${var.server_port}" &
	      EOF
  
}