variable "network_info" {
    description ="this network information for all the resources"
    type = object({
      vpcname = string
      vpccidr = string
      pubsubinfo=list(object({
        subnetnames = list(string)
        subnetcidr = list(string)
        subnetazs = list(string)
      }))
      routablecidr=string
      routablename=string

    })
    default = {
      vpcname = "myvpcnat"
      vpccidr = "10.0.0.0/16"
      pubsubinfo = [ {
        subnetnames=["myvpc1","myvpc2"],
        subnetcidr=["10.0.0.0/24","10.0.1.0/24"],
        subnetazs=["ap-south-1a","ap-south-1b"]
      } ]
      routablename ="myroutetable1"
      routablecidr = "0.0.0.0/0"
      

    }
  
}