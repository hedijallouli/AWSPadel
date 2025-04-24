# Create a custom VPC for the WordPress infrastructure
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "wordpress-vpc"
  }
}

# Create two public subnets (one in each Availability Zone) with auto-assign public IP
resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

# Create two private subnets (one in each Availability Zone) for EC2 and RDS
resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}