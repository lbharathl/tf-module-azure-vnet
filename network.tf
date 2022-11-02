resource "azurerm_virtual_network" "ntier_vnet" {
  name                = var.vnet_details.name
  location            = var.resourcegroup_details.location
  resource_group_name = var.resourcegroup_details.name
  address_space       = var.vnet_details.address_space
  tags = {
    "Env" = "Dev"
  }
  depends_on = [
    azurerm_resource_group.bsquarezone
  ]

}
resource "azurerm_subnet" "ntier_subnets" {
  count                = length(var.subnet_details.name)
  name                 = var.subnet_details.name[count.index]
  resource_group_name  = var.resourcegroup_details.name
  virtual_network_name = var.vnet_details.name
  address_prefixes     = [cidrsubnet(var.vnet_details.address_space[0], 8, count.index)]

  depends_on = [
    azurerm_resource_group.bsquarezone,
    azurerm_virtual_network.ntier_vnet
  ]
}
