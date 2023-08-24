resource "volterra_virtual_site" "virtual_site" {

  name      = var.virtual_site_name
  namespace = var.namespace

  site_selector {
    expressions = local.site_selector
  }
  site_type = "REGIONAL_EDGE"
}
