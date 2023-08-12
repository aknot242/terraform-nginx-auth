variable "tenant" {
  type        = string
  description = "XC tenant name where the objects will be created."
}

variable "site_name" {
  type        = string
  description = "Your F5 XC vk8s site name"
}

variable "namespace" {
  type = string
}

variable "api_token" {
  type = string
}

variable "kubeconfig_file" {
  type = string
}
