variable "tenant" {
  type        = string
  description = "XC tenant name where the objects will be created."
}

variable "namespace" {
  type = string
}

variable "sentence_app_virtual_site" {
  type = string
  default = "sentence-app-vs"
}

variable "nginx_auth_virtual_site" {
  type = string
  default = "nginx-auth-vs"
}

variable "project_prefix" {
  type = string
}
