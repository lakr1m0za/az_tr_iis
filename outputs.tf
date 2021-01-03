output "iis_lb_entrypoint" {
  description = "DNS for loadbalancer entrypoint"
  value       = azurerm_public_ip.iis_lb_ip.ip_address
}

output "iis-web-server-1" {
  description = "IP for web server 1"
  value = azurerm_public_ip.iis_pub_ip_1.ip_address
}

output "iis-web-server-2" {
  description = "IP for web server 2"
  value = azurerm_public_ip.iis_pub_ip_2.ip_address
}