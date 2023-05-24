#configure aws provider

provider "aws" {
    region = "us-east-1"
  
}


#configure an Ec2 instance 

resource "aws_instance" "demo_server" {
    ami = "ami-0889a44b331db0194"
     instance_type = "t2.micro"
    

    tags = {
      name= "demo-server-example"
          }
  
}
