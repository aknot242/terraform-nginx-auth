variable "namespace" {
  type = string
}

variable "project_prefix" {
  type = string
}

variable "regions" {
  type = string
  description = "A comma separated list of XC REs to include in the custom site. Do not include any quotes. Example: ves-io-dallas, ves-io-seattle"
}
