provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "random_integer" "rand-suffix" {
  min = 10000
  max = 99999
}

resource "azurerm_kubernetes_cluster" "my-k8-cluster" {
  name                = "${var.aks_cluster_name}-${random_integer.rand-suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.aks_cluster_name}-dns"

  default_node_pool {
    name                = var.aks_default_node_pool_name
    vm_size             = var.aks_default_node_pool_vm_size
    min_count           = 1
    max_count           = 3
    enable_auto_scaling = true
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_account" "my-storge-account" {
  name                = "mystorage${random_integer.rand-suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    ip_rules                   = ["92.40.174.102"]
  }
}

resource "azurerm_storage_share" "example" {
  name                 = "aksshare"
  storage_account_name = azurerm_storage_account.my-storge-account.name
  quota                = 5
}

