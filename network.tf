resource "azurerm_virtual_network" "iis_virt_net" {
  name                = "iis_virtual_network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.iis_rg.location
  resource_group_name = azurerm_resource_group.iis_rg.name

  tags = {
    Name        = "IIS virtual network"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "azurerm_subnet" "iis_subnet_1" {
  name                 = "iis_subnet_1"
  resource_group_name  = azurerm_resource_group.iis_rg.name
  virtual_network_name = azurerm_virtual_network.iis_virt_net.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "iis_subnet_2" {
  name                 = "iis_subnet_2"
  resource_group_name  = azurerm_resource_group.iis_rg.name
  virtual_network_name = azurerm_virtual_network.iis_virt_net.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "iis_pub_ip_1" {
  name                = "IIS_public_IP_for_vm_1"
  location            = azurerm_resource_group.iis_rg.location
  resource_group_name = azurerm_resource_group.iis_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "iis_pub_ip_2" {
  name                = "IIS_public_IP_for_vm_2"
  location            = azurerm_resource_group.iis_rg.location
  resource_group_name = azurerm_resource_group.iis_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "iis_lb_ip" {
  name                = "IIS_public_IP_for_LB"
  location            = azurerm_resource_group.iis_rg.location
  resource_group_name = azurerm_resource_group.iis_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "iis_net_int_1" {
  name                = "IIS_network_interface_1"
  location            = azurerm_resource_group.iis_rg.location
  resource_group_name = azurerm_resource_group.iis_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.iis_subnet_1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.iis_pub_ip_1.id
  }
}

resource "azurerm_network_interface" "iis_net_int_2" {
  name                = "IIS_network_interface_2"
  location            = azurerm_resource_group.iis_rg.location
  resource_group_name = azurerm_resource_group.iis_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.iis_subnet_2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.iis_pub_ip_2.id
  }
}
