output "public_ip" {
    value = "${aws_instance.demo-webser.public_ip}"
    
}