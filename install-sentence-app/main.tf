resource "kubectl_manifest" "sentence_app_microservices" {
  override_namespace = var.namespace
  for_each           = toset(data.kubectl_path_documents.sentence_app_microservices_manifests.documents)
  yaml_body          = each.value
}

resource "kubectl_manifest" "sentence_app_nginx" {
  override_namespace = var.namespace
  for_each           = toset(data.kubectl_path_documents.sentence_app_nginx_manifests.documents)
  yaml_body          = each.value
  depends_on = [
    kubectl_manifest.sentence_app_microservices
  ]
}
