locals {
  xc_provider_url = format("https://%s.console.ves.volterra.io/api", var.tenant)
  site_selector   = [format("ves.io/region == %s", var.site_region)]
}