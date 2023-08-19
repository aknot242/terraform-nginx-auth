
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

variable "virtual_site_name" {
  type = string
}

variable "mk8s_site_name" {
  type    = string
  default = ""
}

variable "project_prefix" {
  type = string
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

variable "app_port" {
  type    = string
  default = 443
}

variable "nginx_cert_secret_name" {
  type        = string
  description = "The secret name to be used for the default certificate to be used for NGINX"
  default     = "nginx-tls"
}

variable "nginx_cert_validity_period_hours" {
  type        = number
  description = "The validity period of the certificate generated for NGINX server certificate"
  default     = 8760 # approx 1 year
}
