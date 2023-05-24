
provider "aws" {

    region = "us-east-1"
  
}

resource "aws_security_group" "http_security_group" {
    name= "terraform-example-instance"
    ingress {
            from_port = 8080
            to_port = 8080
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]

}
    
}

resource "aws_instance" "demo_server" {

    ami = "ami-0889a44b331db0194"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.http_security_group.id}"]

    user_data =  <<-EOF
	      #!/bin/bash
	      echo "Hello, World" > index.html
	      nohup busybox httpd -f -p 8080 &
	      EOF

    tags = {
      name = "demo_server"
    }
  
}


output "public_ip" {
    value = "${aws_instance.demo_server.public_ip}"
  
}