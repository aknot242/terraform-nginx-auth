provider "volterra" {
  url = local.xc_provider_url
}

provider "kubectl" {
  alias       = "vk8s"
  config_path = var.kubeconfig_file
}

provider "kubernetes" {
  config_path = var.kubeconfig_file
}

# Create a private key in PEM format
resource "tls_private_key" "nginx_private_key" {
  algorithm = "RSA"
}

# Generates a TLS self-signed certificate using the private key
resource "tls_self_signed_cert" "nginx_self_signed_cert" {
  private_key_pem = tls_private_key.nginx_private_key.private_key_pem

  validity_period_hours = var.nginx_cert_validity_period_hours

  subject {
    # The subject CN field here contains the hostname to secure
    common_name = var.app_fqdn
  }

  allowed_uses = ["key_encipherment", "digital_signature", "server_auth"]
}

resource "kubernetes_secret" "nginx_tls_secret" {
  metadata {
    name      = var.nginx_cert_secret_name
    namespace = var.namespace
  }
  data = {
    "tls.crt" = tls_self_signed_cert.nginx_self_signed_cert.cert_pem
    "tls.key" = tls_private_key.nginx_private_key.private_key_pem
  }
  type = "kubernetes.io/tls"
}

resource "kubectl_manifest" "nginx_app_nginx" {
  provider           = kubectl.vk8s
  override_namespace = var.namespace
  for_each           = toset(data.kubectl_path_documents.nginx_app_nginx_manifests.documents)
  yaml_body          = each.value
}
