locals {
  xc_tenant_full = format("%s-%s", var.tenant, var.tenant_suffix)
  nginx_plus_oidc_image = format("%s/%s/%s", var.nginx_plus_oidc_image_server, var.nginx_plus_oidc_image_owner, var.nginx_plus_oidc_image_name)

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
