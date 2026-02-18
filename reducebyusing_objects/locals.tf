locals {
  pub_subnet_value=length(var.network_info.pubsubinfo[0].subnetazs)>0
}