resource "aws_security_group" "tomcat-sg" {
  name        = "tomcat"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.dev-vpc.id

  ingress {
    description      = "ssh port"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups      = ["${aws_security_group.bastion-sg.id}"]
  }

  ingress {
    description      = "enduser port"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    security_groups      = ["${aws_security_group.alb-sg.id}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tomcat-sg"
  }
}

data "template_file" "user_data" {
  template = "${file("tomcat_install.sh")}"

}


resource "aws_instance" "tomcat" {
  ami           = var.ami
  instance_type = var.type
  subnet_id = aws_subnet.pvtsubnet[0].id
  key_name = aws_key_pair.keyfile.id 
  vpc_security_group_ids = ["${aws_security_group.tomcat-sg.id}"]
  user_data = data.template_file.user_data.rendered

  tags = {
    Name = "ec2-tomcat"
  }
}
