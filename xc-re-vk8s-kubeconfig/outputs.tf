output "kubeconfig_file" {
  value = local_file.kubeconfig.filename
}

output "site_name" {
  value = var.site_name
}
