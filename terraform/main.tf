provider "aws" {
  region = var.aws_region
}

# Crear Key Pair desde tu llave pública
resource "aws_key_pair" "mykey" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# Security Group para permitir SSH
resource "aws_security_group" "ssh" {
  name        = "allow_ssh"
  description = "Permitir SSH"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instancia EC2
resource "aws_instance" "vm" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.medium"
  key_name      = aws_key_pair.mykey.key_name

  subnet_id = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.ssh.id]

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }

  tags = {
    Name = "terraform-lab"
  }
}

data "aws_subnet" "default" {
  default_for_az    = true
  availability_zone = var.availability_zone
}