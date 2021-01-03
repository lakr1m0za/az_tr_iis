resource "azurerm_windows_virtual_machine" "iis_1" {
  name                = "iis-machine-1"
  resource_group_name = azurerm_resource_group.iis_rg.name
  location            = azurerm_resource_group.iis_rg.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  custom_data         = base64encode(file("./script/post_install.ps1"))
  zone                = 1
  network_interface_ids = [
    azurerm_network_interface.iis_net_int_1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_windows_virtual_machine" "iis_2" {
  name                = "iis-machine-2"
  resource_group_name = azurerm_resource_group.iis_rg.name
  location            = azurerm_resource_group.iis_rg.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  custom_data         = base64encode(file("./script/post_install.ps1"))
  zone                = 2
  network_interface_ids = [
    azurerm_network_interface.iis_net_int_2.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}