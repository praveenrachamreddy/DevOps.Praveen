resource "aws_security_group" "bastion-sg" {
  name        = "bastion"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.dev-vpc.id

  ingress {
    description      = "ssh port"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

resource "aws_key_pair" "keyfile" {
  key_name   = "terra-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6RtVFBuWtVnHlg1XRWx3ewRgla1mVwlBLL/qQfYga3vICGAyv97fxwWVPr+vjkWhNS82lkdKwq9+nOFyNDZ8AbzXADurCr21d5lOkppdycmMOr7QLZ2Xj243TcQRUriTgjAai3RjO66WCL+btm8zcfKPxVzx+9+cshaEcDHJjSyV+74fnwrHKqym6eL5LmRwRcfEvWkYCLOzgfyXAWnM7QezlGBvkX5w+ncwLJd6HKLqKExu1Yx8C7kiRGofjqWWDnA1ogmVD2fJHzb9fJZljUT2V3TNrQ/hWtC3WBLfdeNlE60/DLKDAVRhcFfPLy7gLlFFnwYGTVv77PeIhad39 ec2-user@terraform"
}

resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.type
  subnet_id = aws_subnet.pubsubnet[0].id
  key_name = aws_key_pair.keyfile.id
  vpc_security_group_ids = ["${aws_security_group.bastion-sg.id}"]

#If you are creating Instances in a VPC, use vpc_security_group_ids instead.

  tags = {
    Name = "ec2-bastion"
  }
}
