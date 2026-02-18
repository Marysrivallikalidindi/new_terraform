variable "network_info"{
    description="this is the network in dev"
    type = object({
        vpcname = string
        vpccidr = string
        pubsubinfo=list(object({
            subnetnames=list(string)
            subnetcidr=list(string)
            subnetazs=list(string)
        }))
    })
    default = {
      vpcname ="mydalmia-vpc"
      vpccidr = "10.0.0.0/20"
      pubsubinfo = [ {
        subnetnames=["mydalsub1","mydalsub2"]
        subnetcidr=["10.0.0.0/24","10.0.1.0/24"]
        subnetazs=["ap-south-1a","ap-south-1b"]

      } ]
    }
}