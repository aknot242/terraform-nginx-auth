locals {
  xc_provider_url = format("https://%s.console.ves.volterra.io/api", var.tenant)
  xc_tenant_full  = format("%s-%s", var.tenant, var.tenant_suffix)

  #XC LB
  services = {
    "sentence-frontend-nginx" = {
      k8s_service     = "sentence-frontend-nginx"
      k8s_service_tls = false
      k8s_namespace   = var.namespace
      k8s_port        = 80
      outside_network = false
      vk8s_networks   = true
    }
  }

  routes = {
    "1" = {
      path          = "/"
      k8s_service   = local.services.sentence-frontend-nginx.k8s_service
      k8s_namespace = local.services.sentence-frontend-nginx.k8s_namespace
      http_method   = "ANY"
    }
  }
}
