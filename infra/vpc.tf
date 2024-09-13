resource "aws_vpc" "vpc" {
  cidr_block            = var.vpc_cidr
  enable_dns_support    = true
  enable_dns_hostnames  = true

  tags = {
        Name = "${var.cluster_name}-vpc"
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
        Name = "${aws_eks_cluster.public.name}-igw"
    }
}

resource "aws_subnet" "public" {
  for_each = {
    for index, az in var.availability_zones : index => {
      availability_zone = az
      cidr_block        = var.public_cidr_blocks[index]
    }
  }

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
        Name = "${var.cluster_name}-public-subnet-${each.key}"
    }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
        Name = "${var.cluster_name}-rt"
    }
}

resource "aws_route_table_association" "public" {
  for_each      = aws_subnet.public
  route_table_id = aws_route_table.public.id
  subnet_id     = each.value.id
}
