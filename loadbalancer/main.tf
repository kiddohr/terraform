module "vpc" {
  source = "./modules/vpc"
  cidr = var.cidr
  sub1Cidr = var.sub1Cidr
  sub2Cidr = var.sub2Cidr
}

module "ec2" {
  source = "./modules/ec2"
  ami = var.ami
  instance_type = var.instance_type
  sg_id = module.vpc.SG-myvpc
  sn1_id = module.vpc.sb1
  sn2_id = module.vpc.sb2
}

module "lb" {
  source = "./modules/lb"
  sg_id = module.vpc.SG-myvpc
  sn1_id = module.vpc.sb1
  sn2_id = module.vpc.sb2
  vpc_id = module.vpc.myvpc
  instance1_id = module.ec2.server1
  instance2_id = module.ec2.server2
}