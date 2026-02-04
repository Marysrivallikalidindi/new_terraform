resource "aws_vpc" "mydemovpc" {
    cidr_block = var.network_info.vpccidr
    tags = {
      Name = var.network_info.vpcname

    }
  
}
resource "aws_subnet" "subnets" {
    count = length(var.network_info.subnets[0].subnetcidr)
    vpc_id = aws_vpc.mydemovpc.id
    cidr_block = var.network_info.subnets[0].subnetcidr[count.index]
    availability_zone = var.network_info.subnets[0].subnetazs[count.index]
    tags = {
      Name = var.network_info.subnets[0].subnetname[count.index]
    }
  
}