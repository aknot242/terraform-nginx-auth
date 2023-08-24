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

variable "nginx_plus_oidc_image_server" {
  type        = string
  description = "The image registry server hosting NGINX OIDC image. Example: ghcr.io"
}

variable "nginx_plus_oidc_image_owner" {
  type        = string
  description = "The owner name of the NGINX OIDC image."
}

variable "nginx_plus_oidc_image_name" {
  type        = string
  description = "The name of the NGINX OIDC image. Example: nginx-oidc"
}

variable "nginx_plus_oidc_image_token" {
  type        = string
  description = "The developer token that has permissions to pull the nginx_plus_oidc_image"
  sensitive   = true
}

variable "project_prefix" {
  type    = string
  default = "nginx-auth"
}

variable "kubeconfig_file" {
  type    = string
  default = "nginx-auth-kubeconfig.yaml"
}

variable "sentence_app_name" {
  type    = string
  default = "demo-sentence"
}

variable "sentence_app_fqdn" {
  type = string
}

variable "sentence_frontend_service_name" {
  type    = string
  default = "sentence-frontend-nginx"
}

variable "sentence_frontend_service_port" {
  type    = number
  default = 80
}

variable "sentence_app_region" {
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

variable "nginx_app_region" {
  type        = string
  description = "The string referencing an XC RE to deploy to"
}

variable "azure_directory_id" {
  type        = string
  description = "The Azure Tenant (directory) ID"
  sensitive   = true
}

variable "azure_oidc_client_id" {
  type        = string
  description = "The Azure Application (client) ID"
  sensitive   = true
}

variable "azure_oidc_client_secret" {
  type        = string
  description = "The Azure Client Secret Value"
  sensitive   = true
}

variable "azure_oidc_hmac_key" {
  type        = string
  description = "The random hmac key phrase"
  sensitive   = true
}
