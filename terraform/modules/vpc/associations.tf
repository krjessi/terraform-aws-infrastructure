#############################################
# Public Route Table Associations
#############################################

resource "aws_route_table_association" "public" {

  count = length(aws_subnet.public)

  subnet_id = aws_subnet.public[count.index].id

  route_table_id = aws_route_table.public.id
}

#############################################
# Private App Associations
#############################################

resource "aws_route_table_association" "private_app" {

  count = length(aws_subnet.private_app)

  subnet_id = aws_subnet.private_app[count.index].id

  route_table_id = aws_route_table.private_app.id
}

#############################################
# Private DB Associations
#############################################

resource "aws_route_table_association" "private_db" {

  count = length(aws_subnet.private_db)

  subnet_id = aws_subnet.private_db[count.index].id

  route_table_id = aws_route_table.private_db.id
}