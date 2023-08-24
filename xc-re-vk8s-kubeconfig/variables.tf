variable "vk8s_name" {
  type        = string
  description = "Your F5 XC vk8s cluster name"
}

variable "namespace" {
  type = string
}

variable "kubeconfig_file" {
  type = string
}

variable "kubeconfig_expiration_days" {
  type    = number
  default = 30
}
