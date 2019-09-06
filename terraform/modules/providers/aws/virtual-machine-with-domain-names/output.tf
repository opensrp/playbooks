output "vm_ids" {
  value = module.vm.vm_ids

  depends_on = [
    module.vm
  ]
}