variable "network_info" {
    description = "mynetwork"
    type = object({
       vpcname = string
       vpccidr = string
       subnets = list(object({
         subnetcidr = list(string)
         subnetname = list(string)
         subnetazs = list(string)
       }))
    })
    default = {
      vpcname = "myvpcinfotech"
      vpccidr = "10.0.0.0/16"
      subnets = [ {
        subnetcidr = ["10.0.0.0/24","10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
        subnetname = ["sub1","sub2","sub3","sub4"]
        subnetazs = ["ap-south-1a","ap-south-1b","ap-south-1c","ap-south-1c"]
        } ]
    }
  
}