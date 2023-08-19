data "template_file" "sentence_app_microservices_templates" {
  template = file("${path.module}/${var.templates_folder}/${var.microservices_file}.tpl")
  vars = {
    namespace = "${var.namespace}"
  }
}

data "template_file" "sentence_app_nginx_templates" {
  template = file("${path.module}/${var.templates_folder}/${var.nginx_file}.tpl")
  vars = {
    namespace = "${var.namespace}"
  }
}

data "kubectl_path_documents" "sentence_app_microservices_manifests" {
  pattern = "${path.module}/${var.tmp_folder}/${var.microservices_file}.yaml"
}

data "kubectl_path_documents" "sentence_app_nginx_manifests" {
  pattern = "${path.module}/${var.tmp_folder}/${var.nginx_file}.yaml"
}
