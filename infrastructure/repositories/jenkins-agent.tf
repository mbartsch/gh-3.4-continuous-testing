module "jenkins" {
  source = "./module"
  name   = "jenkins-agent-2021"
}

output "url" {
  value = module.jenkins.url
}

output "name" {
  value = module.jenkins.name
}
