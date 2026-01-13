locals {
  config = yamldecode(file("${path.module}/config/values.yml"))

  default_tags = {
    environment = var.environment
  }
}
