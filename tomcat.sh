cd /opt
sudo amazon-linux-extras install java-openjdk11
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.23/bin/apache-tomcat-10.0.23.tar.gz
tar -xvzf apache-tomcat-10.0.23.tar.gz
mv apache-tomcat-10.0.23 tomcat
rm -rf apache-tomcat-10.0.23.tar.gz
cd /opt/tomcat/bin
sh startup.sh
