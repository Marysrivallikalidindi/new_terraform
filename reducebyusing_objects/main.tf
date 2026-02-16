resource "aws_vpc" "Myvpc"{
    cidr_block="10.0.0.0/16"
    tags={
        Name="myvpcdalmia"
    }
}
resource "aws_subnet" "subnets"{
    count=2
    vpc_id =aws_vpc.Myvpc.id
    cidr_block = ["10.0.0.0/24","10.0.1.0/24"]
    availability_zone = ["ap-south-1a","ap-south-1b"]
    tags={
        Name=["pubsub1","pubsub2"]

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
resource "aws_internet_gateway" "myinternetgateway"
{
    vpc_id = aws_vpc.Myvpc.id
    tags={
        Name="mydalmiainternetgateway"
    }
    depends_on=[aws_vpc.Myvpc]
}
resource "aws_route_table_association" "mypublicroute"
{
    route_table_id=aws_route_table.myroutetable.id
    subnet_id=aws_subnet.subnets[2].id
    depends_on=[aws_route_table.myroutetable,aws_subnet.subnets]


}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "Myvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "myvpcdalmia"
  }
}

resource "aws_subnet" "subnets" {
  count = 2

  vpc_id            = aws_vpc.Myvpc.id
  cidr_block        = element(["10.0.0.0/24", "10.0.1.0/24"], count.index)
  availability_zone = element(["ap-south-1a", "ap-south-1b"], count.index)

  tags = {
    Name = element(["pubsub1", "pubsub2"], count.index)
  }
}

resource "aws_internet_gateway" "myinternetgateway" {
  vpc_id = aws_vpc.Myvpc.id

  tags = {
    Name = "mydalmiainternetgateway"
  }
}

resource "aws_route_table" "myroutetable" {
  vpc_id = aws_vpc.Myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myinternetgateway.id
  }

  tags = {
    Name = "myroutedalmia"
  }
}

resource "aws_route_table_association" "mypublicroute" {
  count = 2
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.myroutetable.id
}
