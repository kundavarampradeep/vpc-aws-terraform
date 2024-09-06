resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    var.common_tags,
    var.vpc_tags
  )
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.igw_tags
  )
}

resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidr)
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr[count.index]
    availability_zone = var.azs[count.index]

    tags = merge(
        var.common_tags,
        {
            Name = var.public_subnet_names[count.index]
        }

    )
}

resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidr)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr[count.index]
    availability_zone = var.azs[count.index]

    tags = merge(
        var.common_tags,
        {
            Name = var.private_subnet_names[count.index]
        }

    )
}

resource "aws_subnet" "data_base" {
    count = length(var.data_base_subnet_cidr)
    vpc_id = aws_vpc.main.id
    cidr_block = var.data_base_subnet_cidr[count.index]
    availability_zone = var.azs[count.index]

    tags = merge(
        var.common_tags,
        {
            Name = var.data_base_subnet_names[count.index]
        }

    )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.public_route_table_tags
  )
}

resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
  depends_on = [ aws_route_table.public ]
  
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr)  
  subnet_id      = element(aws_subnet.public[*].id , count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.private_route_table_tags
  )
}

resource "aws_route_table_association" "private" {
  count = length (var.private_subnet_cidr)
  subnet_id      = element(aws_subnet.private[*].id , count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table" "data_base" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.data_base_route_table_tags
  )
}

resource "aws_route_table_association" "data_base" {
  count = length(var.data_base_subnet_cidr)
  subnet_id      = element(aws_subnet.data_base[*].id , count.index)
  route_table_id = aws_route_table.data_base.id
}
