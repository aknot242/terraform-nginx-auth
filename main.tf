module "xc-re-vk8s" {
  source         = "./xc-re-vk8s"
  tenant         = var.tenant
  useremail      = var.useremail
  namespace      = var.sentence_app_namespace
  project_prefix = var.sentence_app_project_prefix
  site_region    = var.sentence_app_site_region
}

module "xc-re-vk8s-kubeconfig" {
  source          = "./xc-re-vk8s-kubeconfig"
  tenant          = var.tenant
  namespace       = var.sentence_app_namespace
  site_name       = module.xc-re-vk8s.vk8s_site_name
  api_token       = var.api_token
  kubeconfig_file = var.kubeconfig_file
}
