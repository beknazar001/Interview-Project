output "option_group_id" {
  description = "The db option group id"
  value       = aws_db_option_group.db_opt_gr.id
}

output "db_option_group_arn" {
  description = "The ARN of the db option group"
  value       = aws_db_option_group.db_opt_gr.arn
}

output "subnet_group_id" {
  value = aws_db_subnet_group.db_sg.id
}

