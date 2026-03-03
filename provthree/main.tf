data "aws_vpc" "myexistingvpc" {
  default = true
}
data "aws_subnet" "default_public" {
  default_for_az    = true
  availability_zone = "ap-south-1a"
}
resource "aws_security_group" "mysg1" {
  name        = "myopensg"
  description = "all networks ports allowing"
  vpc_id      = data.aws_vpc.myexistingvpc.id
}
resource "aws_vpc_security_group_ingress_rule" "myingressrule" {
  security_group_id = aws_security_group.mysg1.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}
resource "aws_vpc_security_group_ingress_rule" "myingressrule2" {
  security_group_id = aws_security_group.mysg1.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.mysg1.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
resource "aws_key_pair" "myownkeypair" {
  key_name   = "myownsshkey"
  public_key = file("~/id_ed25519.pub")

}
data "aws_ami" "myami" {
  filter {
    name   = "name"
    values = ["ubuntu-eks-pro/k8s_1.31/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20251115"]
  }
  owners = ["099720109477"]
}
resource "aws_instance" "myec2" {
  ami                         = data.aws_ami.myami.id
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.myownkeypair.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.mysg1.id]
  subnet_id                   = data.aws_subnet.default_public.id
  tags = {
    Name = "myterraformec2"
  } 
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/id_ed25519")
    host        = aws_instance.myec2.public_ip
  }
    provisioner "file" {
        source = "./webapplication.sh"
        destination = "/home/ubuntu/webapplication.sh"
    }
    provisioner "file" {
        source = "Mary_srivalli jpg (1).jpeg"
        destination = "tmp/Mary_srivalli jpg (1).jpeg"      
    }
    provisioner "local-exec" {
        command = "mkdir demo"
      
    }
}



