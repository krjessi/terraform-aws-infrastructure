#############################################
# Elastic IP for NAT Gateway
#############################################

resource "aws_eip" "nat" {

  count = var.enable_nat_gateway ? 1 : 0

  domain = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-nat-eip"
    }
  )
}

#############################################
# NAT Gateway
#############################################

resource "aws_nat_gateway" "main" {

  count = var.enable_nat_gateway ? 1 : 0

  allocation_id = aws_eip.nat[0].id

  subnet_id = aws_subnet.public[0].id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-nat"
    }
  )

  depends_on = [
    aws_internet_gateway.main
  ]
}