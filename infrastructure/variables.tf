#Globals
variable "location" {
  type    = string
  default = "uksouth"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "aks-fileshare-integration"
}

#K8 Cluster
variable "aks_cluster_name" {
  type = string
  default = "my-k8-cluster"
}

variable "aks_default_node_pool_name"{
    type = string
    default = "agentpool"
}

variable "aks_default_node_pool_vm_size"{
    type = string
    default = "standard_b2s"
}