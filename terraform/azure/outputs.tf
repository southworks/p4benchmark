output "driver_public_ip" {
  description = "Public IP address of the driver VM instance"
  value       = azurerm_linux_virtual_machine.driver.public_ip_address
}

output "helix_core_commit_public_ip" {
  description = "Helix Core public IP address"
  value       = azurerm_linux_virtual_machine.helix_core.id
}

output "helix_core_commit_private_ip" {
  description = "Helix Core private IP address"
  value       = azurerm_linux_virtual_machine.helix_core.private_ip_address
}

output "helix_core_commit_instance_id" {
  description = "Helix Core Instance ID - This is the password for the perforce user"
  value       = azurerm_linux_virtual_machine.helix_core.public_ip_address
}
