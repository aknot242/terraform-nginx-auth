provider "volterra" {
  url = local.xc_provider_url
}

provider "kubectl" {
  alias       = "vk8s"
  config_path = var.kubeconfig_file
}

resource "local_file" "sentence_app_microservices_manifests" {
  content  = data.template_file.sentence_app_microservices_templates.rendered
  filename = "${path.module}/${var.tmp_folder}/${var.microservices_file}.yaml"
}

resource "local_file" "sentence_app_nginx_manifests" {
  content  = data.template_file.sentence_app_nginx_templates.rendered
  filename = "${path.module}/${var.tmp_folder}/${var.nginx_file}.yaml"
}

resource "kubectl_manifest" "sentence_app_microservices" {
  provider           = kubectl.vk8s
  override_namespace = var.namespace
  for_each           = toset(data.kubectl_path_documents.sentence_app_microservices_manifests.documents)
  yaml_body          = each.value
  depends_on = [
    local_file.sentence_app_microservices_manifests
  ]
}

resource "kubectl_manifest" "sentence_app_nginx" {
  provider           = kubectl.vk8s
  override_namespace = var.namespace
  for_each           = toset(data.kubectl_path_documents.sentence_app_nginx_manifests.documents)
  yaml_body          = each.value
  depends_on = [
    local_file.sentence_app_nginx_manifests,
    kubectl_manifest.sentence_app_microservices
  ]
}
