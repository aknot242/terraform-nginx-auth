data "kubectl_path_documents" "sentence_app_microservices_manifests" {
  pattern = "${path.module}/${var.templates_folder}/${var.microservices_file}.tpl"
  vars = {
    namespace             = "${var.namespace}"
    virtual_site_name     = "${var.virtual_site_name}"
  }
}

data "kubectl_path_documents" "sentence_app_nginx_manifests" {
  pattern = "${path.module}/${var.templates_folder}/${var.nginx_file}.tpl"
  vars = {
    namespace             = "${var.namespace}"
    virtual_site_name     = "${var.virtual_site_name}"
  }
}
