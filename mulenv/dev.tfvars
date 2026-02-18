variable "network_info"{
    vpcname="myvpc1"
    vpccidr="10.0.0.0/16"
    pubsubinfo=[{
        subnetazs=["ap-south-1a","ap-south-1b"]
        subnetcidr=["10.0.0.0/24","10.0.1.0/24"]
        subnetnames=["subdev1","subdev2"]
    }]
}