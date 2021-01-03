resource "azurerm_resource_group" "iis_rg" {
  name     = "iis_resource_group"
  location = var.location

  tags = {
    Name        = "IIS webserver resource group"
    Terraform   = "true"
    Environment = "dev"
  }
}
