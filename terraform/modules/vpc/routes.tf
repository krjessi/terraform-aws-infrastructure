#############################################
# Public Internet Route
#############################################

resource "aws_route" "public_internet_access" {

  route_table_id = aws_route_table.public.id

  destination_cidr_block = "0.0.0.0/0"

  gateway_id = aws_internet_gateway.main.id
}

#############################################
# Private Application Route
#############################################

resource "aws_route" "private_app_nat" {

  count = var.enable_nat_gateway ? 1 : 0

  route_table_id = aws_route_table.private_app.id

  destination_cidr_block = "0.0.0.0/0"

  nat_gateway_id = aws_nat_gateway.main[0].id
}

#############################################
# Private Database Route
#############################################

resource "aws_route" "private_db_nat" {

  count = var.enable_nat_gateway ? 1 : 0

  route_table_id = aws_route_table.private_db.id

  destination_cidr_block = "0.0.0.0/0"

  nat_gateway_id = aws_nat_gateway.main[0].id
}