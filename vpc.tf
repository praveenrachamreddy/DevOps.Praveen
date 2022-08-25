resource "aws_vpc" "dev-vpc" {
  cidr_block           = var.cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "dev-vpc"
  }
}

resource "aws_subnet" "pubsubnet" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = element(var.pub_cidr, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "pubsubnet[${count.index + 1}]"
  }
}

resource "aws_subnet" "pvtsubnet" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = element(var.pvt_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "pvtsubnet[${count.index + 1}]"
  }
}

resource "aws_subnet" "datasubnet" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = element(var.data_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "datasubnet[${count.index + 1}]"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = "internetgw"
  }
}
resource "aws_eip" "eip" {
  vpc = true
  tags = {
    Name = "elasticIp"
  }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pubsubnet[0].id

  tags = {
    Name = "natgw"
  }
}

resource "aws_route_table" "pubroute" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "pubroute"
  }
}

resource "aws_route_table" "pvtroute" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "pvtroute"
  }
}

resource "aws_route_table" "dataroute" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "dataroute"
  }
}

resource "aws_route_table_association" "pubassos" {
  count          = length(var.azs)
  subnet_id      = element(aws_subnet.pubsubnet.*.id, count.index)
  route_table_id = aws_route_table.pubroute.id
}

resource "aws_route_table_association" "pvtassos" {
  count          = length(var.azs)
  subnet_id      = element(aws_subnet.pvtsubnet.*.id, count.index)
  route_table_id = aws_route_table.pvtroute.id
}

resource "aws_route_table_association" "dataassos" {
  count          = length(var.azs)
  subnet_id      = element(aws_subnet.datasubnet.*.id, count.index)
  route_table_id = aws_route_table.dataroute.id
}
