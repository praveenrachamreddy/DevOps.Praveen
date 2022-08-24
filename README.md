# DevOps.Praveen
first create vpc (dev-vpc/pub-subnet1,2/pvt-subnet1,2/data-subnet1,2/pub-rt/pvt-rt/ig/ng)
create sg for bastian/jenkins/tomcat/alb/ansible
create bastian in dev-pub-1/jenkins in dev-pvt-1/tomcat in dev-pvt-1/alb in dev-pub-1 (pub availabilityzones)/ansible in pvt-sub-2/
login to bastian and copy pem file to home location and login to jenkins 
on jenkins install git/mvn/jenkins/ enable jenkins user on /etc/passwd  with bash 
install mavenintigration plugin and build war file by using mvn clean package
install ansible and copy tomcat ip to /etc/ansible/hosts (check sg of tomcat allow from ansible and ssh-keygen )
after building war send it to ansible server with scp (before that allow sg and do ssh-keygen and copy pub key ) to particular location /opt/ansible on ansible server 
then do ansible-playbook copy_file.yml 

