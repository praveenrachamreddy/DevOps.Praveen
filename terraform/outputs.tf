output "vpc" {
  value = aws_vpc.dev-vpc.id
}

output "bastion-sg"{
  value = aws_security_group.bastion-sg.id
}
output "bastion"{
  value = aws_instance.bastion.id
}
output "keyfile"{
  value = aws_key_pair.keyfile.id
}
output "pubsubnet"{
  value= aws_subnet.pubsubnet.*.id
}
output "pvtsubnet"{
  value= aws_subnet.pvtsubnet.*.id
}
output "datasubnet"{
  value= aws_subnet.datasubnet.*.id
}
output "igw"{
  value= aws_internet_gateway.igw.id
}
output "eip"{
  value= aws_eip.eip.id
}
output "natgw"{
  value= aws_nat_gateway.natgw.id 
}
output "pubroute"{
  value= aws_route_table.pubroute.id
}
output "pvtroute"{
  value= aws_route_table.pvtroute.id
}
output "dataroute"{
  value= aws_route_table.dataroute.id
}
output "pubassos"{
  value= aws_route_table_association.pubassos.*.id
}
output "pvtassos"{
  value= aws_route_table_association.pvtassos.*.id
}
output "dataassos"{
  value= aws_route_table_association.dataassos.*.id
}
output "alb-sg"{
  value= aws_security_group.alb-sg.id
}
output "alb"{
  value= aws_lb.alb.id
}
output "tomcat-sg"{
  value= aws_security_group.tomcat-sg.id
}
output "test"{
  value= aws_lb_target_group_attachment.test.id
}
output "front_end"{
  value= aws_lb_listener.front_end.id
}

output "tomcat"{
  value= aws_instance.tomcat.id
}
