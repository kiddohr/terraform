resource "aws_vpc" "myvpc" {
    cidr_block = var.cidr
}

resource "aws_subnet" "sb1" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.sub1Cidr
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "sb2" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.sub2Cidr
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw-vpc" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "RT-myvpc" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-vpc.id
  }
}

resource "aws_route_table_association" "RTS1" {
    subnet_id = aws_subnet.sb1.id
    route_table_id = aws_route_table.RT-myvpc.id
}

resource "aws_route_table_association" "RTS2" {
  subnet_id = aws_subnet.sb2.id
  route_table_id = aws_route_table.RT-myvpc.id
}

resource "aws_security_group" "SG-myvpc" {
    vpc_id = aws_vpc.myvpc.id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

output "myvpc" {
  value = aws_vpc.myvpc.id
}

output "SG-myvpc" {
  value = aws_security_group.SG-myvpc.id
}
output "sb1" {
  value = aws_subnet.sb1.id
}
output "sb2" {
 value = aws_subnet.sb2.id
}