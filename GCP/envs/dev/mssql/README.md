<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mssql"></a> [mssql](#module\_mssql) | ../../modules/mssql | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_type"></a> [availability\_type](#input\_availability\_type) | The availability type for the master instance.This is only used to set up high availability for the MSSQL instance. Can be either `ZONAL` or `REGIONAL`. | `string` | n/a | yes |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | The database version to use: SQLSERVER\_2017\_STANDARD, SQLSERVER\_2017\_ENTERPRISE, SQLSERVER\_2017\_EXPRESS, or SQLSERVER\_2017\_WEB | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name for Cloud SQL instance | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project to run tests against | `string` | n/a | yes |
| <a name="input_read_replicas"></a> [read\_replicas](#input\_read\_replicas) | List of read replicas to create. Encryption key is required for replica in different region. For replica in same region as master set encryption\_key\_name = null | <pre>list(object({<br>    name                  = string<br>    name_override         = optional(string)<br>    tier                  = string<br>    availability_type     = string<br>    zone                  = string<br>    disk_type             = string<br>    disk_autoresize       = bool<br>    disk_autoresize_limit = number<br>    disk_size             = string<br>    user_labels           = map(string)<br>    # database_flags = list(object({<br>    #   name  = string<br>    #   value = string<br>    # # }))<br>    # ip_configuration = object({<br>    #   authorized_networks = list(map(string))<br>    #   ipv4_enabled        = bool<br>    #   private_network     = string<br>    #   require_ssl         = bool<br>    #   allocated_ip_range  = string<br>    # })<br>    encryption_key_name = string<br>  }))</pre> | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | The region of the Cloud SQL resources | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | The tier for the master instance. | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone for the master instance. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | The name for Cloud SQL instance |
| <a name="output_mssql_connection"></a> [mssql\_connection](#output\_mssql\_connection) | The connection name of the master instance to be used in connection strings |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | n/a |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | Public ip address |
<!-- END_TF_DOCS -->