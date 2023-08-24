resource "volterra_virtual_site" "virtual_site" {

  name      = format("%s-vs", var.project_prefix)
  namespace = var.namespace

  site_selector {
    expressions = local.site_selector
  }
  site_type = "REGIONAL_EDGE"
}
