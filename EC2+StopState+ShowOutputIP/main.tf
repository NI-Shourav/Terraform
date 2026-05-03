resource "aws_instance" "new_ec2_instance" {
  tags = {
    Name = "My-Auto-VM"
  }

  ami = "ami-03f65b8614a860c29"
  instance_type = "t3.micro"
  key_name      = "terra-pc-key"
}

resource "aws_ec2_instance_state" "my_state" {
  instance_id = aws_instance.new_ec2_instance.id
  state       = "stopped"
}

output "machine_ip" {
  value = aws_instance.new_ec2_instance.public_ip
}