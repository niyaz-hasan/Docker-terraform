variable "tg_arn" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "name" {
  type = string
}

variable "user_data" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}
