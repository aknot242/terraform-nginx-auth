resource "volterra_api_credential" "create_kubeconfig" {
  name                  = var.site_name
  api_credential_type   = "KUBE_CONFIG"
  virtual_k8s_namespace = var.namespace
  virtual_k8s_name      = var.site_name
}

resource "local_file" "kubeconfig" {
  filename       = var.kubeconfig_file
  content_base64 = volterra_api_credential.create_kubeconfig.data
}
