variable "tenant" {
  type        = string
  description = "XC tenant name where the objects will be created."
}

variable "useremail" {
  type = string
}

variable "api_token" {
  type = string
}

variable "kubeconfig_file" {
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

