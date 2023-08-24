provider "volterra" {
  url = local.xc_provider_url
}

provider "kubectl" {
  config_path = var.kubeconfig_file
}

provider "kubernetes" {
  config_path = var.kubeconfig_file
}

module "xc-virtual-site-sentence" {
  source            = "./xc-virtual-site"
  virtual_site_name = var.sentence_app_virtual_site
  namespace         = var.namespace
  project_prefix    = var.project_prefix
  regions           = var.sentence_app_region
}

module "xc-virtual-site-nginx" {
  source            = "./xc-virtual-site"
  virtual_site_name = var.nginx_auth_virtual_site
  namespace         = var.namespace
  project_prefix    = var.project_prefix
  regions           = var.nginx_app_region
}

module "xc-re-vk8s" {
  source                    = "./xc-re-vk8s"
  tenant                    = var.tenant
  namespace                 = var.namespace
  project_prefix            = var.project_prefix
  sentence_app_virtual_site = module.xc-virtual-site-sentence.virtual_site_name
  nginx_auth_virtual_site   = module.xc-virtual-site-nginx.virtual_site_name
}

module "xc-re-vk8s-kubeconfig" {
  source          = "./xc-re-vk8s-kubeconfig"
  namespace       = var.namespace
  vk8s_name       = module.xc-re-vk8s.vk8s_name
  kubeconfig_file = var.kubeconfig_file
  depends_on      = [module.xc-re-vk8s]
}

module "install-sentence-app" {
  source                  = "./install-sentence-app"
  tenant                  = var.tenant
  tenant_suffix           = var.tenant_suffix
  namespace               = var.namespace
  project_prefix          = var.project_prefix
  virtual_site_name       = var.sentence_app_virtual_site
  nginx_auth_virtual_site = module.xc-virtual-site-nginx.virtual_site_name
  kubeconfig_file         = module.xc-re-vk8s-kubeconfig.kubeconfig_file
  app_name                = var.sentence_app_name
  app_fqdn                = var.sentence_app_fqdn
}

module "install-nginx-auth" {
  source                         = "./install-nginx-auth"
  tenant                         = var.tenant
  tenant_suffix                  = var.tenant_suffix
  namespace                      = var.namespace
  project_prefix                 = var.project_prefix
  virtual_site_name              = var.nginx_auth_virtual_site
  kubeconfig_file                = module.xc-re-vk8s-kubeconfig.kubeconfig_file
  app_name                       = var.nginx_app_name
  app_fqdn                       = var.nginx_app_fqdn
  sentence_app_fqdn              = var.sentence_app_fqdn
  sentence_frontend_service_name = var.sentence_frontend_service_name
  sentence_frontend_service_port = var.sentence_frontend_service_port
  nginx_plus_oidc_image_server   = var.nginx_plus_oidc_image_server
  nginx_plus_oidc_image_owner    = var.nginx_plus_oidc_image_owner
  nginx_plus_oidc_image_name     = var.nginx_plus_oidc_image_name
  nginx_plus_oidc_image_token    = var.nginx_plus_oidc_image_token
  azure_directory_id             = var.azure_directory_id
  azure_oidc_client_id           = var.azure_oidc_client_id
  azure_oidc_client_secret       = var.azure_oidc_client_secret
  azure_oidc_hmac_key            = var.azure_oidc_hmac_key
}
