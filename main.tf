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
         sudo dnf update -y
         sudo dnf install -y docker
         sudo systemctl enable docker
         sudo systemctl start docker
         sudo usermod -aG docker ec2-user
         sleep 10
         docker run -d -p 80:80  -e OPENPROJECT_SECRET_KEY_BASE=secret -e OPENPROJECT_HTTPS=false  openproject/openproject:15.4.1
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


