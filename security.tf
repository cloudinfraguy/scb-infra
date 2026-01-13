/* Public VM SG – allow SSH from a single IP */
resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "Security group for public VM"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = local.config.allowed_cidr_list # "Allow SSH from a specific list of subnets"
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/* Private VM SG – allow traffic only from the public VM */
resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Security group for private VM"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "All traffic from public VM SG"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [aws_security_group.public_sg.id] # "Allow traffic from public VM only"
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
