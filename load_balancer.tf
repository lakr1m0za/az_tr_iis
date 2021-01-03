resource "azurerm_lb" "iis_lb" {
  name                = "iis_load_balancer"
  location            = azurerm_resource_group.iis_rg.location
  resource_group_name = azurerm_resource_group.iis_rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "publicIPadress"
    public_ip_address_id = azurerm_public_ip.iis_lb_ip.id
  }
}

resource "azurerm_lb_rule" "iis_lb_rule" {
  resource_group_name            = azurerm_resource_group.iis_rg.name
  loadbalancer_id                = azurerm_lb.iis_lb.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.iis_backend.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  probe_id                       = azurerm_lb_probe.iis_lb_probe.id
  frontend_ip_configuration_name = "publicIPadress"
}

resource "azurerm_lb_probe" "iis_lb_probe" {
  resource_group_name = azurerm_resource_group.iis_rg.name
  loadbalancer_id     = azurerm_lb.iis_lb.id
  name                = "iis_health_probe"
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 15
  number_of_probes    = 2
}

resource "azurerm_lb_backend_address_pool" "iis_backend" {
  resource_group_name = azurerm_resource_group.iis_rg.name
  loadbalancer_id     = azurerm_lb.iis_lb.id
  name                = "BackEndAddressPool"
}

resource "azurerm_network_interface_backend_address_pool_association" "iis_NIC_backend_1" {
  network_interface_id    = azurerm_network_interface.iis_net_int_1.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.iis_backend.id
}

resource "azurerm_network_interface_backend_address_pool_association" "iis_NIC_backend_2" {
  network_interface_id    = azurerm_network_interface.iis_net_int_2.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.iis_backend.id
}
