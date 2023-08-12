variable "tenant" {
  type        = string
  description = "XC tenant name where the objects will be created."
}

variable "namespace" {
  type = string
}

variable "project_prefix" {
  type = string
}

variable "useremail" {
  type = string
}

variable "site_region" {
  type = string
  description = "The string referencing an XC RE to deploy to"
}