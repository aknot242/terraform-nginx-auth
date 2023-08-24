
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

variable "sentence_app_fqdn" {
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

variable "sentence_frontend_service_name" {
  type    = string
  default = "sentence-frontend-nginx"
}

variable "sentence_frontend_service_port" {
  type    = number
  default = 80
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

variable "tmp_folder" {
  type    = string
  default = "tmp"
}

variable "templates_folder" {
  type    = string
  default = "templates"
}

variable "nginx_auth_file" {
  type    = string
  default = "nginx-auth"
}

variable "nginx_pull_secret_name" {
  type    = string
  default = "ghcr"
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
