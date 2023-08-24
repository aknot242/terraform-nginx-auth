locals {
  site_selector = [format("ves.io/region in (%s)", var.regions)]
}
