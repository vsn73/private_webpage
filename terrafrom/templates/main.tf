module "vm" {
  source = "../module-A"
  rg-name = var.rg-name
  location = var.location
  vnet-name = var.vnet-name
  sub-name = var.sub-name
  nic-name = var.nic-name
  private-ip-name = var.private-ip-name
  vmname = var.vmname
}


