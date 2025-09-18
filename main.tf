provider "aws" {
  region = "us-east-1"
}

# EC2 Security Group - Allow SSH (22), Jenkins (8080), HTTP (80)
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow SSH, HTTP and Jenkins port"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All traffic out"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { Name = "jenkins-vpc" }
}

# Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "jenkins-subnet" }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "jenkins-igw" }
}

# Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "jenkins-rt" }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt.id
}

# EC2 Instance with Jenkins install
resource "aws_instance" "jenkins" {
  ami                    = "ami-0886832e6b5c3b9e2" # Amazon Linux 2
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name               = "first_server1" # <-- change to your key

  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              set -e
              yum update -y
              yum install -y wget
              yum install -y git
              dnf install -y java-17-amazon-corretto

              wget -O /etc/yum.repos.d/jenkins.repo \
                https://pkg.jenkins.io/redhat/jenkins.repo
              rpm --import https://pkg.jenkins.io/redhat/jenkins.io-2023.key
              yum upgrade -y
              yum install -y jenkins

              systemctl enable jenkins
              systemctl start jenkins
              EOF

  tags = { Name = "jenkins-server" }
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}
