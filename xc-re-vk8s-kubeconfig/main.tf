data "http" "kubeconfig" {
  method = "POST"
  url    = format("https://%s.console.ves.volterra.io/api/web/namespaces/%s/api_credentials", var.tenant, var.namespace)
  request_headers = {
    Accept        = "application/json"
    Authorization = format("APIToken %s", var.api_token)
  }
  request_body = jsonencode({
    name            = var.site_name
    namespaces      = var.namespace
    expiration_days = 1
    spec = {
      type                  = "KUBE_CONFIG"
      users                 = []
      password              = null
      virtual_k8s_name      = var.site_name
      virtual_k8s_namespace = var.namespace
    }
  })
}

locals {
  kubeconfig_location = "xc-re-vk8s-kubeconfig.yaml"
}

resource "local_file" "kubeconfig" {
  filename = local.kubeconfig_location
  content  = base64decode(jsondecode(data.http.kubeconfig.response_body).data)
}

output "kubeconfig_file" {
  value = local_file.kubeconfig.filename
}

output "site_name"{
  value = var.site_name
}
