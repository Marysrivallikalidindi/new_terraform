resource "aws_vpc" "mydemovpc"{
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "myterraformvpc"
    }
}
resource "aws_subnet" "mysub1" {
    vpc_id = aws_vpc.mydemovpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "subnet1"
    }
  
}
resource "aws_subnet" "mysub2" {
    vpc_id = aws_vpc.mydemovpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1b"
    tags = {
        Name = "subnet2"
    }
  
}
resource "aws_subnet" "mysub3" {
    vpc_id = aws_vpc.mydemovpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "ap-south-1c"
    tags = {
      Name = "subnet3"
    }
  
}
resource "aws_subnet" "mysub4" {
    vpc_id = aws_vpc.mydemovpc.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "ap-south-1c"
    tags = {
      Name = "subnet4"
    }
  
}
