output "public_vm_ip" {
  value = aws_instance.public_vm.public_ip
}

output "private_vm_private_ip" {
  value = aws_instance.private_vm.private_ip
}
