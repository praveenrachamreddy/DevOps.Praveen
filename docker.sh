sudo yum -y update
sudo yum install -y docker
systemctl start docker
systemctl enable docker
systemctl status docker
docker --version
