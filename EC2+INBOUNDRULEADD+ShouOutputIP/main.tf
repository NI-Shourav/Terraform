resource "aws_instance" "new_ec2_instance" {
  tags = {
    Name = "My-Auto-VM"
  }

  ami = "ami-0d76b909de1a0595d"
  instance_type = "t3.micro"
  key_name      = "terra-pc-key"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
}

resource "aws_default_vpc" "default" {
}

resource "aws_security_group" "my_sg" {
  name        = "nur-sg"
  description = "Awesome SG"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh access key"
  }
}

output "machine_ip" {
  value = aws_instance.new_ec2_instance.public_ip
}
