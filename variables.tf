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
  type    = string
  default = "demo-sentence"
}

variable "sentence_app_fqdn" {
  type = string
}

variable "sentence_app_kubeconfig_file" {
  type    = string
  default = "sentence-app-kubeconfig.yaml"
}

variable "sentence_app_namespace" {
  type = string
}

variable "sentence_app_project_prefix" {
  type    = string
  default = "sentence-app"
}

variable "sentence_app_site_region" {
  type        = string
  description = "The string referencing an XC RE to deploy to"
}

variable "nginx_app_name" {
  type    = string
  default = "demo-nginx-auth"
}

variable "nginx_app_fqdn" {
  type = string
}

variable "nginx_app_kubeconfig_file" {
  type    = string
  default = "nginx-auth-kubeconfig.yaml"
}

variable "nginx_app_namespace" {
  type = string
}

variable "nginx_app_project_prefix" {
  type    = string
  default = "nginx-auth"
}

variable "nginx_app_site_region" {
  type        = string
  description = "The string referencing an XC RE to deploy to"
}

variable "azure_directory_id" {
  type = string
  description = "The Azure Tenant (directory) ID"
}

variable "azure_oidc_client_id" {
  type = string
  description = "The Azure Application (client) ID"
}

variable "azure_oidc_client_secret" {
  type = string
  description = "The Azure Client Secret Value"
}

variable "azure_oidc_hmac_key" {
  type = string
  description = "The random hmac key phrase"
}
