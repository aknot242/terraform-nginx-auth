data "kubectl_path_documents" "nginx_manifests" {
  pattern = "${path.module}/${var.templates_folder}/*.tpl"
  vars = {
    namespace                = "${var.namespace}"
    nginx_plus_oidc_image    = "${local.nginx_plus_oidc_image}"
    nginx_pull_secret_name   = "${var.nginx_pull_secret_name}"
    virtual_site_name        = "${var.virtual_site_name}"
    sentence_app_fqdn        = "${var.sentence_app_fqdn}"
    app_port                 = "${var.app_port}"
    azure_directory_id       = "${var.azure_directory_id}"
    azure_oidc_client_id     = "${var.azure_oidc_client_id}"
    azure_oidc_client_secret = "${var.azure_oidc_client_secret}"
    azure_oidc_hmac_key      = "${var.azure_oidc_hmac_key}"
  }
}
