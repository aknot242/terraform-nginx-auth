output "site_region" {
  value = var.site_region
}

output "vk8s_site_name" {
  value = volterra_virtual_k8s.vk8s.name
}

output "virtual_site_name" {
  value = volterra_virtual_site.virtual_site.name
}

output "virtual_site_namespace" {
  value = volterra_virtual_site.virtual_site.namespace
}
