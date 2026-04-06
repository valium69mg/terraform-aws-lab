variable "aws_region" {
  description = "Región de AWS"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t2.medium"
}

variable "key_name" {
  description = "Nombre del key pair para SSH"
}

variable "public_key_path" {
  description = "Ruta al archivo de tu llave pública SSH"
}

variable "my_ip" {
  description = "Tu IP pública para SSH"
  default     = ""
}

variable "availability_zone" {
  description = "Availability Zone para el subnet por defecto"
  default     = "us-east-1a"
}