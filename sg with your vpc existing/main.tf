data "aws_vpc" "myexistingvpc"{
    filter {
      name="tag:Name"
      values = [ "myvpc"]
    }
}
resource "aws_security_group" "mysg1"{
    name = "myopensg"
    description="all networks ports allowing"
    vpc_id=data.aws_vpc.myexistingvpc.id


}
resource "aws_vpc_security_group_ingress_rule" "myingressrule"{
    security_group_id = aws_security_group.mysg1.id
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"



}