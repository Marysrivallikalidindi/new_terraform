resource "aws_vpc" "Myvpc"{
    cidr_block=var.network_info.vpccidr
    tags={
        Name=var.network_info.vpcname
    }
}
resource "aws_subnet" "subnets"{
    count=local.pub_subnet_value?1:0
    vpc_id =aws_vpc.Myvpc.id
    cidr_block = var.network_info.pubsubinfo[0].subnetcidr[count.index]
    availability_zone = var.network_info.pubsubinfo[0].subnetazs[count.index]
    tags={
        Name=var.network_info.pubsubinfo[0].subnetnames[count.index]

    }
    depends_on=[aws_vpc.Myvpc]

}
resource"aws_route_table" "myroutetable"{
    vpc_id=aws_vpc.Myobjvpc.id
    route{
        cidr_block="0.0.0.0/0"
        gateway_id= aws_internet_gateway.myinternetgateway.id
    }
    tags={
        Name="myroutedalmia"

    }
    depends_on=[aws_vpc.Myvpc]

}
resource "aws_internet_gateway" "myinternetgateway"{
    vpc_id = aws_vpc.Myvpc.id
    tags={
        Name="mydalmiainternetgateway"
    }
    depends_on=[aws_vpc.Myvpc]
}
resource "aws_route_table_association" "mypublicroute"{
  count = local.pub_subnet_value?1:0
    route_table_id=aws_route_table.myroutetable.id
    subnet_id=aws_subnet.subnets[0].id
    depends_on=[aws_route_table.myroutetable,aws_subnet.subnets]


}


