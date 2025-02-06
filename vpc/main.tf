### Create a VPC
resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    name        = "${var.environment}-${var.name}"
    environment = var.environment
  }
}


### PUBLIC SECTION
### =======================================================================

### Create Public Subnets
resource "aws_subnet" "public" {
  count = length(var.public_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = element(var.public_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  #map_public_ip_on_launch = true

  tags = {
    name        = "${var.environment}-${var.name}-public-${count.index + 1}"
    environment = var.environment
  }
}

# Create Route Table for Public Traffic
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    name        = "${var.environment}-${var.name}-public"
    environment = var.environment
  }
}

### Associate Public Subnet with Route Table
resource "aws_route_table_association" "public" {
  count = length(var.public_cidrs)

  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

### Create Internet Gateway
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.this.id

  tags = {
    name        = "${var.environment}-${var.name}"
    environment = var.environment
  }
}

### Create Route Table for Internet Gateway
resource "aws_route_table" "ig" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    name        = "${var.environment}-${var.name}-local"
    environment = var.environment
  }
}


### PRIVATE SECTION
### =======================================================================

### Create Private Subnets
resource "aws_subnet" "private" {
  count = length(var.private_cidrs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = element(var.private_cidrs, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = false

  tags = {
    name        = "${var.environment}-${var.name}-${count.index + 1}-private"
    environment = var.environment
  }
}

# Create Route Table for Private Traffic
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    name        = "${var.environment}-${var.name}-private"
    environment = var.environment
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_cidrs)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

# Create Elastic-IP (eip) for NAT
resource "aws_eip" "nat" {
  # vpc        = true
  depends_on = [aws_internet_gateway.ig]
}

# Create NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = element(aws_subnet.private.*.id, 0)

  tags = {
    name        = "${var.environment}-${var.name}"
    environment = var.environment
  }
}
