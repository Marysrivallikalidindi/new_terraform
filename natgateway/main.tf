resource "aws_vpc" "mynatvpc" {
    cidr_block = var.network_info.vpccidr
    tags = {
      Name = var.network_info.vpcname
    }
  
}
resource "aws_subnet" "mynatsubnets" {
    vpc_id = aws_vpc.mynatvpc.id
    count=local.pub_subnet_value
    cidr_block = var.network_info.pubsubinfo[0].subnetcidr[count.index]
    availability_zone = var.network_info.pubsubinfo[0].subnetazs[count.index]

    tags={
        Name= var.network_info.pubsubinfo[0].subnetnames[count.index]
    }  
    depends_on = [ aws_vpc.mynatvpc ]
}
resource "aws_route_table" "myroutetablenew" {
    vpc_id = aws_vpc.mynatvpc.id
    count = local.pub_subnet_value
    route{
        cidr_block = var.network_info.routablecidr
        nat_gateway_id = aws_nat_gateway.mynategateway[count.index].id

    }  
    tags = {
      Name=var.network_info.routablename
    }
    depends_on = [ aws_nat_gateway.mynategateway,aws_vpc.mynatvpc ]
}
resource "aws_nat_gateway" "mynategateway" {
    connectivity_type = "private"
    subnet_id = aws_subnet.mynatsubnets[0].id
    count = local.pub_subnet_value
    depends_on = [ aws_subnet.mynatsubnets ]
  
}
resource "aws_route_table_association" "myrouteassociation" {
    route_table_id = aws_route_table.myroutetablenew[0].id
    subnet_id = aws_subnet.mynatsubnets[1].id
    count = local.pub_subnet_value
    depends_on = [  aws_route_table.myroutetablenew,aws_subnet.mynatsubnets]


  
}

