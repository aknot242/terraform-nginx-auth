provider "volterra" {
  url = local.xc_provider_url
}

provider "kubectl" {
  alias       = "kubectl_sentence_app"
  config_path = var.sentence_app_kubeconfig_file
}

provider "kubectl" {
  alias       = "kubectl_nginx_app"
  config_path = var.nginx_app_kubeconfig_file
}

module "sentence-xc-re-vk8s" {
  source         = "./xc-re-vk8s"
  tenant         = var.tenant
  useremail      = var.useremail
  namespace      = var.sentence_app_namespace
  project_prefix = var.sentence_app_project_prefix
  site_region    = var.sentence_app_site_region
}

module "sentence-xc-re-vk8s-kubeconfig" {
  source          = "./xc-re-vk8s-kubeconfig"
  tenant          = var.tenant
  namespace       = var.sentence_app_namespace
  site_name       = module.sentence-xc-re-vk8s.vk8s_site_name
  kubeconfig_file = var.sentence_app_kubeconfig_file
  depends_on      = [module.sentence-xc-re-vk8s]
}

module "install-sentence-app" {
  source = "./install-sentence-app"
  providers = {
    kubectl = kubectl.kubectl_sentence_app
  }
  tenant            = var.tenant
  tenant_suffix     = var.tenant_suffix
  namespace         = var.sentence_app_namespace
  project_prefix    = var.sentence_app_project_prefix
  virtual_site_name = module.sentence-xc-re-vk8s.virtual_site_name
  kubeconfig_file   = module.sentence-xc-re-vk8s-kubeconfig.kubeconfig_file
  app_name          = var.sentence_app_name
  app_fqdn          = var.sentence_app_fqdn
}

module "nginx-xc-re-vk8s" {
  source         = "./xc-re-vk8s"
  tenant         = var.tenant
  useremail      = var.useremail
  namespace      = var.nginx_app_namespace
  project_prefix = var.nginx_app_project_prefix
  site_region    = var.nginx_app_site_region
}

module "nginx-xc-re-vk8s-kubeconfig" {
  source          = "./xc-re-vk8s-kubeconfig"
  tenant          = var.tenant
  namespace       = var.nginx_app_namespace
  site_name       = module.nginx-xc-re-vk8s.vk8s_site_name
  kubeconfig_file = var.nginx_app_kubeconfig_file
  depends_on      = [module.nginx-xc-re-vk8s]
}

module "install-nginx-auth" {
  source = "./install-nginx-auth"
  providers = {
    kubectl = kubectl.kubectl_nginx_app
  }
  tenant                   = var.tenant
  tenant_suffix            = var.tenant_suffix
  namespace                = var.nginx_app_namespace
  project_prefix           = var.nginx_app_project_prefix
  virtual_site_name        = module.nginx-xc-re-vk8s.virtual_site_name
  kubeconfig_file          = module.nginx-xc-re-vk8s-kubeconfig.kubeconfig_file
  app_name                 = var.nginx_app_name
  app_fqdn                 = var.nginx_app_fqdn
  proxied_app_fqdn         = var.sentence_app_fqdn
  azure_directory_id       = var.azure_directory_id
  azure_oidc_client_id     = var.azure_oidc_client_id
  azure_oidc_client_secret = var.azure_oidc_client_secret
  azure_oidc_hmac_key      = var.azure_oidc_hmac_key
}
