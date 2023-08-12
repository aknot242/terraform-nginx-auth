locals {
  xc_provider_url = format("https://%s.console.ves.volterra.io/api", var.tenant)
  site_selector = [format("ves.io/siteType = ves-io-re, ves.io/siteName = %s", var.site_region)]
}
