module "ecr" {
  source = "./module"
  name   = "rabbit-test"
}

output "url" {
  value = module.ecr.url
}

output "name" {
  value = module.ecr.name
}
