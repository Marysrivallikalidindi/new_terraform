resource "aws_vpc" "mynatvpc" {
    cidr_block = var.network_info.vpccidr
    tags = {
      Name = var.network_info.vpcname
    }
  
}
resource "aws_subnet" "mynatsubnets" {
    vpc_id = aws_vpc.mynatvpc.id
    count=local.pub_subnet_value
    cidr_block = var.network_info.pubsubinfo[0].subnetcidr
    availability_zone = var.network_info.pubsubinfo[0].subnetazs

    tags={
        Name= var.network_info.pubsubinfo[0].subnetnames
    }  
    depends_on = [ aws_vpc.mynatvpc ]
}
resource "aws_route_table" "myroutetablenew" {
    vpc_id = aws_vpc.mynatvpc.id
    count = local.pub_subnet_value?1:0
    route{
        cidr_block = var.network_info.routablecidr
        nat_gateway_id =aws_nat_gateway.mynategateway.id

    }  
    tags = {
      Name=var.network_info.routablename
    }
}
resource "aws_nat_gateway" "mynategateway" {
    connectivity_type = "private"
    subnet_id = aws_subnet.mynatsubnets[0].id
    count = local.pub_subnet_value?1:0
  
}
resource "aws_route_table_association" "myrouteassociation" {
    route_table_id = aws_route_table.myroutetablenew.id
    subnet_id = aws_subnet.mynatsubnets[0].id

  
}

