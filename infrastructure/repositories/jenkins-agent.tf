module "jenkins" {
  source = "./module"
  name   = "jenkins-agent"
}

output "url" {
  value = module.jenkins.url
}
