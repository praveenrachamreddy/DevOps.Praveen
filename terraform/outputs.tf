output "vpc" {
  value = aws_vpc.dev-vpc.id
}

output "bastion-sg"{
  value = aws_security_group.bastion-sg.id
}
output "bastion"{
  value = aws_instance.bastion.id
}
