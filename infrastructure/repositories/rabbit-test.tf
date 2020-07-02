module "rabbit" {
  source = "./module"
  name   = "rabbit-test"
}

output "rabbit-url" {
  value = module.rabbit.url
}

output "rabbit-name" {
  value = module.rabbit.name
}
