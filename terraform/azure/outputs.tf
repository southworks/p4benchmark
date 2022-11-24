output "driver_public_ip" {
  description = "Public IP address of the driver VM instance"
  value       = azurerm_linux_virtual_machine.driver.public_ip_address
}
