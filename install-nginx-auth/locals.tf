locals {
  xc_provider_url = format("https://%s.console.ves.volterra.io/api", var.tenant)
  xc_tenant_full  = format("%s-%s", var.tenant, var.tenant_suffix)

  #XC LB
  services = {
    "nginx-auth" = {
      k8s_service     = "nginx-auth"
      k8s_service_tls = true
      k8s_namespace   = var.namespace
      k8s_port        = 443
      outside_network = false
      vk8s_networks   = true
    }
  }

  routes = {
    "1" = {
      path          = "/"
      k8s_service   = local.services.nginx-auth.k8s_service
      k8s_namespace = local.services.nginx-auth.k8s_namespace
      http_method   = "ANY"
    }
  }
}
