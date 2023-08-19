data "kubectl_path_documents" "nginx_app_nginx_manifests" {
  pattern = "${path.module}/manifests/*.yaml"
}
