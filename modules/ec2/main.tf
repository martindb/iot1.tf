data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "cloudinit_config" "config" {
  part {
    content_type = "text/x-shellscript"
    content      = file("${path.root}/bootstrap/ec2setup.sh")
  }

  part {
    content_type = "text/cloud-config"
    content = yamlencode({
      write_files = [
        {
          encoding    = "b64"
          content     = filebase64("˜/.ssh/id_rsa")
          path        = "/home/ubuntu/.ssh/id_rsa"
          owner       = "ubuntu:ubuntu"
          permissions = "0400"
        },
        {
          encoding    = "b64"
          content     = filebase64("˜/.ssh/id_rsa.pub")
          path        = "/home/ubuntu/.ssh/id_rsa.pub"
          owner       = "ubuntu:ubuntu"
          permissions = "0400"
        },
      ]
    })
  }
}

resource "aws_instance" "ec2" {
  count                       = var.ec2_should_be_created ? 1 : 0

  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.ec2_instance_type

  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2_security_group.id]
  associate_public_ip_address = true

#  key_name                    = aws_key_pair.ec2_key_pair.key_name

  tags = {
    Name = var.ec2_name
  }

  user_data = data.cloudinit_config.config.rendered

}

resource "aws_security_group" "ec2_security_group" {
  name        = var.ec2_security_group_name
  description = var.ec2_security_group_description

  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1880
    to_port     = 1880
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1883
    to_port     = 1883
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ingress {
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.ec2_security_group_name
  }

}

#resource "aws_key_pair" "ec2_key_pair" {
#  key_name   = var.ec2_ssh_key_name
#  public_key = file(var.ec2_ssh_public_key_path)
#}
