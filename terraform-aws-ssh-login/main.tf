provider "aws" {
    region = "us-east-1"
  
}

resource "aws_security_group" "ssh-access" {
    name = "ssh-access"
    description = "ssh-login"
    ingress {
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

resource "aws_key_pair" "web" {
    public_key = file("mypub.pub")
  
}

resource "aws_instance" "demo_server" {
    ami = "ami-0889a44b331db0194"
    instance_type = "t2.micro"
    tags = {
      name = "demo-server-ssh-login"

    }
    vpc_security_group_ids = ["${aws_security_group.ssh-access.id}"]
    user_data =  <<-EOF
	      #!/bin/bash
	      echo "Hello, World" > index.html
	      nohup busybox httpd -f -p "${var.server_port}" &
	      EOF
  

    key_name = aws_key_pair.web.id
} 


