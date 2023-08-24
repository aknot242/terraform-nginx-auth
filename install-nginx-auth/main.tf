provider "kubernetes" {
  config_path = var.kubeconfig_file
}

# Create a private key in PEM format
resource "tls_private_key" "nginx_private_key" {
  algorithm = "RSA"
}

# Generates a TLS self-signed certificate using the private key
resource "tls_self_signed_cert" "nginx_self_signed_cert" {
  private_key_pem       = tls_private_key.nginx_private_key.private_key_pem
  validity_period_hours = var.nginx_cert_validity_period_hours
  allowed_uses          = ["key_encipherment", "digital_signature", "server_auth"]
  subject {
    # The subject CN field here contains the hostname to secure
    common_name = var.app_fqdn
  }
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

resource "kubernetes_secret" "nginx_pull_secret" {
  metadata {
    name      = var.nginx_pull_secret_name
    namespace = var.namespace
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.nginx_plus_oidc_image_server}" = {
          "username" = var.nginx_plus_oidc_image_owner
          "password" = var.nginx_plus_oidc_image_token
          "auth"     = base64encode("${var.nginx_plus_oidc_image_owner}:${var.nginx_plus_oidc_image_token}")
        }
      }
    })
  }
}

resource "kubectl_manifest" "nginx_app_nginx" {
  override_namespace = var.namespace
  for_each           = toset(data.kubectl_path_documents.nginx_manifests.documents)
  yaml_body          = each.value
  depends_on         = [kubernetes_secret.nginx_tls_secret, kubernetes_secret.nginx_pull_secret]
}
