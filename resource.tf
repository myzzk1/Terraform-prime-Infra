resource "aws_vpc" "prime" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "prime"
  }
}

# to create igw
# https://registry.terraform.io/providers/aaronfeng/aws/latest/docs/resources/internet_gateway

resource "aws_internet_gateway" "prime-igw" {
  vpc_id = aws_vpc.prime.id

  tags = {
    Name = "prime-igw"
  }
}

# to create a public subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet.html

resource "aws_subnet" "prime-pub1" {
  vpc_id            = aws_vpc.prime.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "prime-pub1"
  }
}

# creating public subnet 2

resource "aws_subnet" "prime-pub2" {
  vpc_id            = aws_vpc.prime.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "prime-pub2"
  }
}

# creating a route table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table

resource "aws_route_table" "prime-pub-route_table" {
  vpc_id = aws_vpc.prime.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prime-igw.id
  }
  tags = {
    Name = "prime-pub-route_table"
  }
}

# associating subnet
# 
resource "aws_route_table_association" "prime-pub1" {
  subnet_id      = aws_subnet.prime-pub1.id
  route_table_id = aws_route_table.prime-pub-route_table.id
}

# associating subnet 2 
resource "aws_route_table_association" "prime-pub2" {
  subnet_id      = aws_subnet.prime-pub2.id
  route_table_id = aws_route_table.prime-pub-route_table.id
}

# to create a public private subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet.html

resource "aws_subnet" "prime-priv1" {
  vpc_id            = aws_vpc.prime.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "prime-piv1"
  }
}

# creating private subnet 2

resource "aws_subnet" "prime-prive2" {
  vpc_id            = aws_vpc.prime.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "prime-prive2"
  }
}

#private rt
resource "aws_route_table" "prime-private-route_table" {
  vpc_id = aws_vpc.prime.id
  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_internet_gateway.prime-igw.id
  # }
  tags = {
    Name = "prime-private-route_table"
  }
}


# associating subnet
# 
resource "aws_route_table_association" "prime-priv1" {
  subnet_id      = aws_subnet.prime-priv1.id
  route_table_id = aws_route_table.prime-private-route_table.id
}

# associating subnet 2 
resource "aws_route_table_association" "prime-priv2" {
  subnet_id      = aws_subnet.prime-prive2.id
  route_table_id = aws_route_table.prime-private-route_table.id
}


