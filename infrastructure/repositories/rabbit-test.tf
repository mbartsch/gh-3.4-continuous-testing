module "rabbit" {
  source = "./module"
  name   = "rabbit-test-2021"
}

output "rabbit-url" {
  value = module.rabbit.url
}

output "rabbit-name" {
  value = module.rabbit.name
}
