data "template_file" "nginx_templates" {
  template = file("${path.module}/${var.templates_folder}/${var.nginx_auth_file}.tpl")
  vars = {
    proxied_app_fqdn         = "${var.proxied_app_fqdn}"
    azure_directory_id       = "${var.azure_directory_id}"
    azure_oidc_client_id     = "${var.azure_oidc_client_id}"
    azure_oidc_client_secret = "${var.azure_oidc_client_secret}"
    azure_oidc_hmac_key      = "${var.azure_oidc_hmac_key}"
  }
}

data "kubectl_path_documents" "nginx_manifests" {
  pattern = "${path.module}/${var.tmp_folder}/*.yaml"
}
