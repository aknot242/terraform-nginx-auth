
variable "tenant" {
  type        = string
  description = "XC tenant name where the objects will be created."
}

variable "tenant_suffix" {
  type        = string
  description = "XC tenant unique identifier suffix."
}

variable "namespace" {
  type = string
}

variable "project_prefix" {
  type = string
}

variable "app_deployment_region" {
  type = string
}

variable "virtual_site_name" {
  type = string
}

variable "mk8s_site_name" {
  type    = string
  default = ""
}

variable "kubeconfig_file" {
  type = string
}

variable "app_name" {
  type = string
}

variable "app_fqdn" {
  type = string
}

variable "sentence_lb_cert_validity_period_hours" {
  type        = number
  description = "The validity period of the certificate generated for the Sentence app LB server certificate"
  default     = 8760 # approx 1 year
}

variable "tmp_folder" {
  type    = string
  default = "tmp"
}

variable "templates_folder" {
  type    = string
  default = "templates"
}

variable "microservices_file" {
  type    = string
  default = "sentence-api-all"
}

variable "nginx_file" {
  type    = string
  default = "sentence-nginx-webapp"
}
