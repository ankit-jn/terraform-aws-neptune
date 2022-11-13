# ARJ-Stack: AWS Neptune Service, Terraform module

A Terraform module for provisioning AWS Neptune, a fast, reliable and fully managed graph database

## Resources
This module features the following components to be provisioned with different combinations:

- Neptune Cluster [[aws_neptune_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_cluster)]
- Neptune Instance [[aws_neptune_cluster_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_cluster_instance)]
- Neptune Endpoint [[aws_neptune_cluster_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_cluster_endpoint)]
- Neptune Subnet Group [[aws_neptune_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_subnet_group)]
- Neptune Cluster Parameter Group [[aws_neptune_cluster_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_cluster_parameter_group)]
- Neptune Parameter Group [[aws_neptune_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_parameter_group)]
- Security Group [[aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)]
- Security Group Rules [[aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)]

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.22.0 |

## Examples

Refer [Configuration Examples](https://github.com/arjstack/terraform-aws-examples/tree/main/aws-neptune) for effectively utilizing this module.

## Inputs

#### DB Cluster specific properties
---
| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="engine"></a> [engine](#input\_engine) | The name of the database engine to be used for this Neptune cluster. | `string` | `"neptune"` | no |  |
| <a name="engine_version"></a> [engine_version](#input\_engine\_version) | The database engine version. | `string` | `null` | no |  |
| <a name="create_cluster"></a> [create_cluster](#input\_create\_cluster) | Flag to decide if cluster should be provisioned | `bool` | `true` | no |  |
| <a name="cluster_name"></a> [cluster_name](#input\_cluster\_name) | The cluster identifier. Required when `create_cluster` is set `true` | `string` | `null` | no |  |
| <a name="availability_zones"></a> [availability_zones](#input\_availability\_zones) | List of EC2 Availability Zones that instances in the Neptune cluster can be created in. | `list(string)` | `[]` | no |  |
| <a name="db_port"></a> [db_port](#input\_db\_port) | The port on which the Neptune accepts connections. | `number` | `8182` | no |  |
| <a name="vpc_id"></a> [vpc_id](#input\_vpc\_id) | The ID of VPC that is used to define the virtual networking environment for this Neptune cluster. | `string` | `""` | no |  |
| <a name="create_neptune_subnet_group"></a> [create_neptune_subnet_group](#input\_create\_neptune\_subnet\_group) | Flag to decide if Neptune subnet group should be created | `bool` | `true` | no |  |
| <a name="neptune_subnet_group_name"></a> [neptune_subnet_group_name](#input\_neptune\_subnet\_group\_name) | The name of the Neptune subnet group. | `string` | `null` | no |  |
| <a name="subnets"></a> [subnets](#input\_subnets) | The list of subnet IDs used by Neptune subnet group | `list(string)` | `[]` | no |  |
| <a name="additional_sg"></a> [additional_sg](#input\_additional\_sg) | List of Existing Security Group IDs associated with Neptune. | `list(string)` | `[]` | no | <pre>[<br>   "sg-xxxxx......",<br>   "sg-xxxx4747cv..."<br>] |
| <a name="create_sg"></a> [create_sg](#input\_create\_sg) | Flag to decide to create Security Group for Neptune | `bool` | `false` | no |  |
| <a name="sg_name"></a> [sg_name](#input\_sg\_name) | The name of the Security group | `string` | `""` | no |  |
| <a name="sg_rules"></a> [sg_rules](#sg\_rules) | Configuration map for Security Group Rules | `map` | `{}` | no | <pre>{<br>   ingress = [<br>      {<br>        rule_name = "Self Ingress Rule"<br>        description = "Self Ingress Rule"<br>        from_port =0<br>        to_port = 0<br>        protocol = "-1"<br>        self = true<br>      },<br>      {<br>        rule_name = "Ingress from IPv4 CIDR"<br>        description = "IPv4 Rule"<br>        from_port = 8182<br>        to_port = 8182<br>        protocol = "tcp"<br>        cidr_blocks = [<br>          "xx.xx.xx.xx/xx",<br>          "yy.yy.yy.yy/yy"<br>        ]<br>      }<br>   ]<br>   egress =[<br>      {<br>        rule_name = "Self Egress Rule"<br>        description = "Self Egress Rule"<br>        from_port =8182<br>        to_port = 8182<br>        protocol = "-1"<br>        self = true<br>      }<br>   ]<br>} |
| <a name="allowed_sg"></a> [allowed_sg](#input\_allowed\_sg) | List of Source Security Group IDs defined in Ingress of the created SG | `list(string` | `[]` | no | |
| <a name="iam_database_authentication_enabled"></a> [iam_database_authentication_enabled](#input\_iam\_database\_authentication\_enabled) | Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled | `bool` | `null` | no |  |
| <a name="backup_retention_period"></a> [backup_retention_period](#input\_backup\_retention\_period) | The days to retain backups for. | `number` | `1` | no |  |
| <a name="copy_tags_to_snapshot"></a> [copy_tags_to_snapshot](#input\_copy\_tags\_to\_snapshot) | Copy all tags from Neptune cluster to snapshots. | `bool` | `false` | no |  |
| <a name="preferred_backup_window"></a> [preferred_backup_window](#input\_preferred\_backup\_window) | The daily time range (in UTC) during which automated backups are created if automated backups are enabled using the backup_retention_period. | `string` | `null` | no |  |
| <a name="snapshot_identifier"></a> [snapshot_identifier](#input\_snapshot\_identifier) | Specifies whether or not to create this cluster from a snapshot. | `string` | `null` | no |  |
| <a name="skip_final_snapshot"></a> [skip_final_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final snapshot is created before the Neptune cluster is deleted. | `bool` | `false` | no |  |
| <a name="final_snapshot_identifier"></a> [final_snapshot_identifier](#input\_final\_snapshot\_identifier) | The name of your final snapshot when this Neptune cluster is deleted. | `string` | `null` | no |  |
| <a name="storage_encrypted"></a> [storage_encrypted](#input\_storage\_encrypted) | Specifies whether the Neptune cluster is encrypted. | `bool` | `null` | no |  |
| <a name="kms_key"></a> [kms_key](#input\_kms\_key) | The reference of the KMS key to use for encryption | `string` | `null` | no |  |
| <a name="enable_cloudwatch_logs_exports"></a> [enable_cloudwatch_logs_exports](#input\_enable\_cloudwatch\_logs\_exports) | Set of log types to export to cloudwatch. | `set(string)` | `[]` | no | ["audit"] |
| <a name="allow_major_version_upgrade"></a> [allow_major_version_upgrade](#input\_allow\_major\_version\_upgrade) | Enable to allow major engine version upgrades when changing engine versions. | `bool` | `false` | no |  |
| <a name="preferred_maintenance_window"></a> [preferred_maintenance_window](#input\_preferred\_maintenance\_window) | The weekly time range during which system maintenance can occur, in (UTC). | `string` | `null` | no | "Sun:04:00-Sun:04:30" |
| <a name="apply_immediately"></a> [apply_immediately](#input\_apply\_immediately) | Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. | `bool` | `false` | no |  |
| <a name="deletion_protection"></a> [deletion_protection](#input\_deletion\_protection) | Flag to decide if the Neptune cluster should have deletion protection enabled. | `bool` | `false` | no |  |
| <a name="create_neptune_cluster_parameter_group"></a> [create_neptune_cluster_parameter_group](#input\_create\_neptune\_cluster\_parameter\_group) | Flag to decide if a new Neptune cluster parameter group should be created | `bool` | `false` | no |  |
| <a name="neptune_cluster_parameter_group"></a> [neptune_cluster_parameter_group](#parameter\_group) | The configuration map of the Neptune cluster parameter group | `map` | `{}` | no | <pre>{<br>   name = "neptune-cluster-arjstack-pg"<br>   family = "neptune1"<br>} |
| <a name="neptune_cluster_parameter_group_parameters"></a> [neptune_cluster_parameter_group_parameters](#parameter\_group\_parameters) | A list of parameters map to apply | `list(map(string))` | `[]` | no | <pre>[<br>   {<br>     name         = "neptune_enable_audit_log"<br>     value        = 1<br>   }<br>] |
| <a name="create_neptune_parameter_group"></a> [create_neptune_parameter_group](#input\_create\_neptune\_parameter\_group) | Flag to decide if a new Neptune instance parameter group should be created | `bool` | `false` | no |  |
| <a name="neptune_parameter_group"></a> [neptune_parameter_group](#parameter\_group) | The configuration map of the Neptune instance parameter group | `map` | `{}` | no | <pre>{<br>   name = "neptune-arjstack-pg"<br>   family = "neptune1"<br>} |
| <a name="neptune_parameter_group_parameters"></a> [neptune_parameter_group_parameters](#parameter\_group\_parameters) | A list of parameters map to apply | `list(map(string))` | `[]` | no | <pre>[<br>   {<br>     name         = "neptune_query_timeout"<br>     value        = 25<br>   }<br>] |

#### Neptune Instance specific properties
---
| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="instance_class"></a> [instance_class](#input\_instance\_class) | The instance class to use for Neptune Instance. | `string` | `null` | no |  |
| <a name="publicly_accessible"></a> [publicly_accessible](#input\_publicly\_accessible) | Flag to decide if instances are publicly accessible. | `bool` | `false` | no |  |
| <a name="auto_minor_version_upgrade"></a> [auto_minor_version_upgrade](#input\_auto\_minor\_version\_upgrade) | Enable to allow minor engine upgrades utomatically to the Neptune instance during the maintenance window. | `bool` | `true` | no |  |
| <a name="instances"></a> [instances](#instances) | List of cluster instances map | `list` | `[]` | no | <pre>[<br>   {<br>     name = "first"<br>     monitoring_granularity = 30<br>   },<br>   {<br>     name = "first"<br>     promotion_tier = 3<br>     preferred_backup_window = 04:00-04:30<br>     preferred_maintenance_window = "Mon:04:00-Mon:04:30"<br>   }<br>] |
| <a name="endpoints"></a> [endpoints](#endpoints) | List of cluster endpoints map | `list` | `[]` | no | <pre>[<br>   {<br>     identifier = "ep-analysis"<br>     type = "READER"<br>     static_members = ["third"]<br>   }<br>] |

#### Tags specific properties
---
| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="default_tags"></a> [default_tags](#input\_default\_tags) | A map of tags to assign to all the resources. | `map(string)` | `{}` | no |
| <a name="cluster_tags"></a> [cluster_tags](#input\_cluster\_tags) | A map of tags to assign to the Neptune cluster. | `map(string)` | `{}` | no |
| <a name="instance_tags"></a> [instance_tags](#input\_instance\_tags) | A map of tags to assign to all the Neptune Instance. | `map(string)` | `{}` | no |

## Nested Configuration Maps:  

#### parameter_group

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="name"></a> [name](#input\_name) | The name of the Neptune parameter group. | `string` |  | yes |
| <a name="family"></a> [family](#input\_family) | The family of the Neptune parameter group | `string` |  | yes |
| <a name="description"></a> [description](#input\_description) | The description of the Neptune parameter group. | `string` |  | no |
| <a name="tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. | `string` | `{}` | no |

#### parameter_group_parameters
| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="name"></a> [name](#input\_name) | The name of the Neptune parameter. | `string` |  | yes |
| <a name="value"></a> [value](#input\_value) | The value of the Neptune parameter. | `string` |  | yes |
| <a name="apply_method"></a> [apply_method](#input\_apply\_method) | "immediate" or "pending-reboot" (default). | `string` | `pending-reboot` | no |

#### instances

- Instance properties defined here are used to override the properties defined commonly for all instances or at the cluster level, e.g.
    - `publicly_accessible` defined at instance level is used to override the commom properties for instances `publicly_accessible` 
    - ...

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="name"></a> [name](#input\_name) | The identifier for the Neptune instance | `string` |  | yes |
| <a name="instance_class"></a> [instance_class](#input\_instance\_class) | The instance class to use. | `string` |  | yes |
| <a name="availability_zone"></a> [availability_zone](#input\_availability\_zone) | The EC2 Availability Zone that the DB instance is created in. | `string` |  | no |
| <a name="publicly_accessible"></a> [publicly_accessible](#input\_publicly\_accessible) | Flag to control if instance is publicly accessible. | `bool` |  | no |
| <a name="promotion_tier"></a> [promotion_tier](#input\_promotion\_tier) | Failover Priority setting on instance level. | `number` | `0` | no |
| <a name="auto_minor_version_upgrade"></a> [auto_minor_version_upgrade](#input\_auto\_minor\_version\_upgrade) | Enable to allow minor engine upgrades utomatically to the DB instance during the maintenance window. | `bool` |  | no |
| <a name="apply_immediately"></a> [apply_immediately](#input\_apply\_immediately) | Specifies whether any instancce modifications are applied immediately, or during the next maintenance window. | `bool` |  | no |
| <a name="preferred_backup_window"></a> [preferred_backup_window](#input\_preferred\_backup\_window) | The daily time range during which automated backups are created if automated backups are enabled. | `number` |  | no |
| <a name="preferred_maintenance_window"></a> [preferred_maintenance_window](#input\_preferred\_maintenance\_window) | The window to perform maintenance in. | `string` |  | no |
| <a name="tags"></a> [tags](#input\_tags) | A map of tags to assign to the Neptune Instance. | `map(string)` | `{}` | no |

#### endpoints

- Either `static_members` or `excluded_members` can be specified as they conflict with each other

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="identifier"></a> [identifier](#input\_identifier) | The identifier to use for the new endpoint. | `string` |  | yes |
| <a name="type"></a> [type](#input\_type) | The type of the endpoint. One of: READER, WRITER, ANY. | `string` |  | yes |
| <a name="static_members"></a> [static_members](#input\_static\_members) | List of Neptune instance identifiers that are part of the custom endpoint group. | `list(string)` | `null` | no |
| <a name="excluded_members"></a> [excluded_members](#input\_excluded\_members) | List of Neptune instance identifiers that are not part of the custom endpoint group. | `list(string)` | `null` | no |
| <a name="tags"></a> [tags](#input\_tags) | A map of tags to assign to the custom endpoint. | `map(string)` | `{}` | no |

#### sg_rules
[ Ingress / Egress ]

- `cidr_blocks` Cannot be specified with `source_security_group_id` or `self`.
- `ipv6_cidr_blocks` Cannot be specified with `source_security_group_id` or `self`.
- `source_security_group_id` Cannot be specified with `cidr_blocks`, `ipv6_cidr_blocks` or `self`.
- `self` Cannot be specified with `cidr_blocks`, `ipv6_cidr_blocks` or `source_security_group_id`.

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="rule_name"></a> [rule_name](#input\_rule\_name) | The name of the Rule (Used for terraform perspective to maintain unicity) | `string` |  | yes |
| <a name="description"></a> [description](#input\_description) | Description of the rule. | `string` |  | yes |
| <a name="from_port"></a> [from_port](#input\_from\_port) | Start port (or ICMP type number if protocol is "icmp" or "icmpv6"). | `number` |  | yes |
| <a name="to_port"></a> [to_port](#input\_to\_port) | End port (or ICMP code if protocol is "icmp"). | `number` |  | yes |
| <a name="protocol"></a> [protocol](#input\_protocol) | Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number | `string \| number` |  | yes |
| <a name="self"></a> [self](#input\_self) | Whether the security group itself will be added as a source to this ingress rule.  | `bool` |  | no |
| <a name="cidr_blocks"></a> [cidr_blocks](#input\_cidr\_blocks) | List of IPv4 CIDR blocks | `list(string)` |  | no |
| <a name="ipv6_cidr_blocks"></a> [ipv6_cidr_blocks](#input\_ipv6\_cidr\_blocks) | List of IPv6 CIDR blocks. | `list(string)` |  | no |
| <a name="source_security_group_id"></a> [source_security_group_id](#input\_source\_security\_group\_id) | Security group id to allow access to/from | `string` |  | no |

## Outputs

| Name | Type | Description |
|:------|:------|:------|
| <a name="cluster_arn"></a> [cluster_arn](#output\_cluster\_arn) | `string` | Neptune Cluster Amazon Resource Name (ARN) |
| <a name="port"></a> [port](#output\_port) | `number` | Database Port |
| <a name="neptune_subnet_group"></a> [neptune_subnet_group](#output\_neptune\_subnet\_group) | `map` | Neptune Subnet Group Map:<br>&nbsp;&nbsp;`id` - The ID/Name of Neptune Subnet Group<br>&nbsp;&nbsp;`arn` - Amazon Resource Name (ARN) of Neptune Subnet group |
| <a name="instances"></a> [instances](#output\_instances) | `map` | Neptune Cluster Instances:<br><b>Map Key:</b> Instance Identifier<br><b>Map Value:</b> Map of the following Instance attributes:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`id` - The ID of Instance<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`arn` - Amazon Resource Name (ARN) of Instance<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`address` - The hostname of the instance.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`endpoint` - Endpoint of the instance<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`writer` - Whether instance is for writing purpose of for Read replica |
| <a name="cluster_endpoint"></a> [cluster_endpoint](#output\_cluster\_endpoint) | `string` | Neptune Cluster Endpint |
| <a name="cluster_reader_endpoint"></a> [cluster_reader_endpoint](#output\_cluster\_reader\_endpoint) | `string` | Neptune Cluster Read only Endpint; automatically load-balanced across replicas |
| <a name="custom_endpoints"></a> [custom_endpoints](#output\_custom\_endpoints) | `map` | Neptune Cluster Custom Endpints:<br><b>Map Key:</b> Endpoint Identifier<br><b>Map Value:</b> Map of the following Custom Endpoint attributes:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`id` - The ID of Custom Endpoint<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`arn` - Amazon Resource Name (ARN) of Custom Endpoint<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`endpoint` - Endpoint |
| <a name="sg_id"></a> [sg_id](#output\_sg\_id) | `string` | The Security Group ID associated to Neptune |

## Authors

Module is maintained by [Ankit Jain](https://github.com/ankit-jn) with help from [these professional](https://github.com/arjstack/terraform-aws-neptune/graphs/contributors).

