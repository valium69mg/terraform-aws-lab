output "public_ip" {
  value = aws_instance.vm.public_ip
  description = "IP pública de la instancia EC2"
}