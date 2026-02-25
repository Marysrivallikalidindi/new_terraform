data "aws_vpc" "myexistingvpc"{
    default=true
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
resource "aws_key_pair" "myownkeypair" {
    key_name = "myownsshkey"
    public_key = file("~/id_ed25519.pub")
  
}
resource "aws_instance" "myec2" {
    ami = "ami-051a31ab2f4d498f5"
    instance_type = "t3.micro"
    key_name = aws_key_pair.myownkeypair.key_name
    associate_public_ip_address = true
    vpc_security_group_ids = [ aws_security_group.mysg1.id ]
    tags = {
      Name = "myterraformec2"
    }

  
}