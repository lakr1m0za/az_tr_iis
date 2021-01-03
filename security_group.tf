resource "azurerm_network_security_group" "iis-nsg" {
  name                = "iis_network_security_group"
  resource_group_name = azurerm_resource_group.iis_rg.name
  location            = azurerm_resource_group.iis_rg.location

  security_rule {
    name                       = "Http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "RDP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "WinRM"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Name        = "IIS network SG"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "azurerm_subnet_network_security_group_association" "iis_subnet_SG_assoc_1" {
  subnet_id                 = azurerm_subnet.iis_subnet_1.id
  network_security_group_id = azurerm_network_security_group.iis-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "iis_subnet_SG_assoc_2" {
  subnet_id                 = azurerm_subnet.iis_subnet_2.id
  network_security_group_id = azurerm_network_security_group.iis-nsg.id
}
