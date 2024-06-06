terraform {
  cloud {
    organization = "dreamapp"

    workspaces {
      name = "dreamapp"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "dreamapp" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "dreamapp"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo docker run -d -p 80:8080 romanvog/dreamapp:latest" #
    ]
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow-http"
  description = "Allow inbound HTTP traffic"
  vpc_id      = "vpc-00a18f292f5fe509f"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group_rule" "allow_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_http.id
}