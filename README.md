## Requirements

No requirements.



## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_VPC"></a> [VPC](#module\_VPC) | ./modules/vpc | n/a |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name for the VPC | `string` | test | no |
| <a name="input_region"></a> [region](#input\_region) | Name for the region | `string` | `"us-east-1"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR range for the VPC | `string` | `"10.10.0.0/16"` | no |
| <a name="input_subnet_count"></a> [name](#input\_subnet_count) | subnet count for each tier | `number` | 2 | no |



## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |











