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
  user_data_a = <<-EOF
              #!/bin/bash
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "<p>Instance A</p>" >> /usr/share/nginx/html/index.html
          EOF

  user_data_b = <<-EOF
              #!/bin/bash
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "<p>Instance B</p>" >> /usr/share/nginx/html/index.html
          EOF
}


module "instances_a" {
  source          = "./modules/instance"
  tg_arn          = module.target_group.arn
  subnet_id       = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.sg_group.ec2_security_group_id]
  user_data       = local.user_data_a
  name            = "instance-a"
}

module "instances_b" {
  source          = "./modules/instance"
  tg_arn          = module.target_group.arn
  subnet_id       = module.vpc.public_subnets[1]
  vpc_security_group_ids = [module.sg_group.ec2_security_group_id]
  user_data       = local.user_data_b
  name            = "instance-b"
}

module "rds" {
  source               = "./modules/rds"
  name                 = var.name
  private_subnets      = module.vpc.private_subnets
  db_username          = "admin"
  db_password          = "y7Yfyr8oHIUvkDs4"
  rds_security_group_ids  = [module.sg_group.rds_security_group_id]
}
