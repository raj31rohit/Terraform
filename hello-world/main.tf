
#configure an AWS Provider
provider "aws" {

    region = "us-east-1"
  
}

# configure an EC2 instance 

resource "aws_instance" "demo_server" {

    ami = "ami-0889a44b331db0194"
    instance_type = "t2.micro"
  
}
