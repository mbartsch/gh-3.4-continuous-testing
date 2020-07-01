output "name" {
  value = aws_ecr_repository.repository.name
}

output "arn" {
  value = aws_ecr_repository.repository.arn
}

output "url" {
  value = aws_ecr_repository.repository.repository_url
}
