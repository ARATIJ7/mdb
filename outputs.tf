# outputs.tf
output "instance1_public_ip" {
  value = aws_instance.mongodb_instance1.public_ip
}

output "instance2_public_ip" {
  value = aws_instance.mongodb_instance2.public_ip
}
