module "vpc" {
  source = "./modules/vpc"
  name           = var.name
  vpc_cidr_block = var.vpc_cidr_block
  
}

module "alb" {
  source      = "./modules/alb"
  vpc_id      = module.vpc.vpc_id
  subnets     = module.vpc.public_subnets
  security_groups = [module.sg_group.alb_security_group_id]
  tg_arns     = [module.target_group.arn]
}

module "target_group" {
  source      = "./modules/target_group"
  name        = "target-group"
  port        = 80
  vpc_id      = module.vpc.vpc_id
  path        = "/"
}



module "sg_group" {
  source     = "./modules/sg_group"
  vpc_id     = module.vpc.vpc_id
}



locals {
  user_data = <<-EOF
         #!/bin/bash
         sudo yum update -y
         sudo amazon-linux-extras install docker -y
         sudo service docker start
         sudo usermod -a -G docker ec2-user
         sleep 10
         sudo docker run -itd -p 80:8080 --name openproject openproject/community:12
    EOF
}




module "instance" {
  source          = "./modules/instance"
  tg_arn          = module.target_group.arn
  subnet_id       = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.sg_group.ec2_security_group_id]
  user_data       = local.user_data
  name            = "Docker-instance"
}


