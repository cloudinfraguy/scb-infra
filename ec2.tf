# Find the latest Amazon Linux 2 AMI in the current region
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  owners = ["amazon"]   # Amazon owns the official AL2 images

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "public_vm" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = local.config.public_vm.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "public-vm"
  }
}

resource "aws_instance" "private_vm" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = local.config.private_vm.instance_type
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  tags = {
    Name = "private-vm"
  }
}
