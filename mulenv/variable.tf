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

}