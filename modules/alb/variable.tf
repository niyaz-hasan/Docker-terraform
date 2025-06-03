variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "tg_arns" {
  type = list(string)
}

variable "security_groups" {
   type = list(string)
}
