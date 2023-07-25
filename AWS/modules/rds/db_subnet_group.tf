resource "aws_db_subnet_group" "db_sg" {
  name        = var.subnet_group_name
  description = var.subnet_group_description
  subnet_ids  = var.subnet_ids

  tags = merge(
    var.tags,
    {
      "Name" = var.subnet_group_name
    },
  )
}