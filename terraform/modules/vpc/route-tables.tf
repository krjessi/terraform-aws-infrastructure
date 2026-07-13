#############################################
# Public Route Table
#############################################

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-public-rt"
    }
  )
}

#############################################
# Private Application Route Table
#############################################

resource "aws_route_table" "private_app" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-private-app-rt"
    }
  )
}

#############################################
# Private Database Route Table
#############################################

resource "aws_route_table" "private_db" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-private-db-rt"
    }
  )
}