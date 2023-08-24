resource "volterra_virtual_k8s" "vk8s" {
  name      = format("%s-vk8s", var.project_prefix)
  namespace = var.namespace
  vsite_refs {
    name      = var.site_name
    namespace = var.namespace
  }
}

resource "null_resource" "wait_for_vk8s" {
  depends_on = [
    volterra_virtual_k8s.vk8s
  ]
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "${path.module}/pre-check-vk8s.sh ${volterra_virtual_k8s.vk8s.name} ${var.namespace} ${local.xc_provider_url}"
  }
}
