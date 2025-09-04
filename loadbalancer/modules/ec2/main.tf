variable "sg_id" {}
variable "sn1_id" {}
variable "sn2_id" {}

resource "aws_instance" "server1" {
    ami = var.ami
    instance_type = var.instance_type
    security_groups = [var.sg_id]
    subnet_id = var.sn1_id
    user_data = base64encode(file("modules/ec2/server1.sh"))
}
resource "aws_instance" "server2" {
    ami = var.ami
    instance_type = var.instance_type
    security_groups = [var.sg_id]
    subnet_id = var.sn2_id
    user_data = base64encode(file("modules/ec2/server2.sh"))
}

output "server1" {
  value = aws_instance.server1.id
}

output "server2" {
  value = aws_instance.server2.id
}

