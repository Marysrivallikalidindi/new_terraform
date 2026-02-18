output "vpcid" {
    value=aws_vpc.Myvpc.id
  
}
output "pusubids" {
    value = aws_subnet.subnets[0].id
  
}
output "routetableid"{
    value = aws_route_table.myroutetable.id

}
output "internetgateway" {
    value = aws_internet_gateway.myinternetgateway.id
  
}
