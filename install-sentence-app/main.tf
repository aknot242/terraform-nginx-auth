# Create a private key in PEM format
resource "tls_private_key" "sentence_lb_private_key" {
  algorithm = "RSA"
}

# Generates a TLS self-signed certificate using the private key
resource "tls_self_signed_cert" "sentence_lb_self_signed_cert" {
  private_key_pem       = tls_private_key.sentence_lb_private_key.private_key_pem
  validity_period_hours = var.sentence_lb_cert_validity_period_hours
  allowed_uses          = ["key_encipherment", "digital_signature", "server_auth"]

  subject {
    # The subject CN field here contains the hostname to secure
    common_name = var.app_fqdn
  }
}

resource "kubectl_manifest" "sentence_app_microservices" {
  override_namespace = var.namespace
  for_each           = toset(data.kubectl_path_documents.sentence_app_microservices_manifests.documents)
  yaml_body          = each.value
  depends_on = [
    tls_self_signed_cert.sentence_lb_self_signed_cert
  ]
}

resource "kubectl_manifest" "sentence_app_nginx" {
  override_namespace = var.namespace
  for_each           = toset(data.kubectl_path_documents.sentence_app_nginx_manifests.documents)
  yaml_body          = each.value
  depends_on = [
    kubectl_manifest.sentence_app_microservices
  ]
}
