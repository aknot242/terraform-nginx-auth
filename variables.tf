variable "tenant" {
  type        = string
  description = "XC tenant name where the objects will be created."
}

variable "tenant_suffix" {
  type        = string
  description = "XC tenant unique identifier suffix."
}

variable "useremail" {
  type = string
}

variable "sentence_app_name" {
  type = string
}

variable "sentence_app_fqdn" {
  type = string
}

variable "sentence_app_kubeconfig_file" {
  type = string
}

variable "sentence_app_namespace" {
  type = string
}

variable "sentence_app_project_prefix" {
  type = string
}

variable "sentence_app_site_region" {
  type        = string
  description = "The string referencing an XC RE to deploy to"
}

variable "nginx_app_name" {
  type = string
}

variable "nginx_app_fqdn" {
  type = string
}

variable "nginx_app_kubeconfig_file" {
  type = string
}

variable "nginx_app_namespace" {
  type = string
}

variable "nginx_app_project_prefix" {
  type = string
}

variable "nginx_app_site_region" {
  type        = string
  description = "The string referencing an XC RE to deploy to"
}

