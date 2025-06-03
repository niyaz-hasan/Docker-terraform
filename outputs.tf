output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "alb_dns" {
  value = module.alb.alb_dns_name
}

output "alb_arn" {
  value = module.alb.alb_dns_name
}

output "target_group_arn" {
  value = module.target_group.arn
}

