#################################################
## Engine options Properties
#################################################
variable "engine" {
    description = "The name of the database engine to be used for this Neptune cluster."
    type        = string
    default     = "neptune"

    validation {
        condition = contains(["neptune"], var.engine)
        error_message = "The valid value for engine is `neptune`." 
    }
}

variable "engine_version" {
    description = "The database engine version."
    type        = string
    default         = null
}

#################################################
## Cluster Settings Properties
#################################################
variable "create_cluster" {
    description = "Flag to decide if Neptune cluster should be provisioned"
    type        = bool
    default     = true
}

variable "cluster_name" {
    description = "The cluster identifier."
    type        = string
    default     = null
}

#################################################
## Availability & durability Properties
#################################################
variable "availability_zones" {
    description = "List of EC2 Availability Zones that instances in the Neptune cluster can be created in."
    type    = list(string)
    default = null
}

#################################################
## Connectivity Properties
#################################################
variable "db_port" {
    description = "The port on which the Neptune accepts connections."
    type        = number
    default     = 8182
}

variable "vpc_id" {
  description   = "The ID of VPC that is used to define the virtual networking environment for this Neptune cluster."
  type          = string 
  default       = ""
}

variable "create_neptune_subnet_group" {
    description = "Flag to decide if Neptune subnet group should be created"
    type        = bool
    default     = true
}

variable "neptune_subnet_group_name" {
    description = "The name of the Neptune subnet group"
    type        = string
    default     = null
}

variable "subnets" {
    description = "The list of subnet IDs used by Neptune subnet group"
    type        = list(string)
    default     = []
}

variable "additional_sg" {
    description = "(Optional) List of Existing Security Group IDs associated with Neptune."
    type        = list(string)
    default     = []
}

variable "create_sg" {
    description = "Flag to decide to create Security Group for Neptune"
    type        = bool
    default     = false
}

variable "sg_name" {
    description = "The name of the Security group"
    type        = string
    default     = ""
}

variable "sg_rules" {
    description = <<EOF

(Optional) Map of Security Group Rules with 2 Keys ingress and egress.
The value for each key will be a list of Security group rules where 
each entry of the list will again be a map of SG Rule Configuration	
SG Rules Configuration: Refer (https://github.com/arjstack/terraform-aws-security-groups/blob/v1.0.0/README.md#security-group-rule--ingress--egress-)
              
EOF
    default = {}
}

variable "allowed_sg" {
    description = "List of Source Security Group IDs defined in Ingress of the created SG"
    type        = list(string)
    default     = []
}
#################################################
## Database authentication Properties
#################################################
variable "iam_database_authentication_enabled" {
    description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
    type        = bool
    default     = null
}

#################################################
## Backup Properties
#################################################
variable "backup_retention_period" {
    description = "The days to retain backups for."
    type        = number
    default     = 1
}

variable "copy_tags_to_snapshot" {
    description = "Copy all tags from Neptune cluster to snapshots."
    type        = bool
    default     = false
}

variable "preferred_backup_window" {
    description = <<EOF
The daily time range (in UTC) during which automated backups are created 
if automated backups are enabled using the backup_retention_period.
EOF
    type    = string
    default = null
}

variable "snapshot_identifier" {
    description = "Specifies whether or not to create this cluster from a snapshot."
    type        = string
    default     = null
}
variable "skip_final_snapshot" {
    description = "Determines whether a final snapshot is created before the Neptune cluster is deleted."
    type        = bool
    default     = false
}

variable "final_snapshot_identifier" {
    description = "The name of your final snapshot when this Neptune cluster is deleted."
    type        = string
    default     = null
}

#################################################
## Encryption Properties
#################################################
variable "storage_encrypted" {
    description = "Specifies whether the Neptune cluster is encrypted."
    type        = bool
    default     = null
}

variable "kms_key" {
    description = <<EOF
The reference of the KMS key to use for encryption.
key Reference could be either of this format:

- 1234abcd-12ab-34cd-56ef-1234567890ab
- arn:aws:kms:<region>:<account no>:key/1234abcd-12ab-34cd-56ef-1234567890ab
- alias/my-key
- arn:aws:kms:<region>:<account no>:alias/my-key
EOF
    type    = string
    default = null
}

#################################################
## Log Exports Properties
#################################################
variable "enable_cloudwatch_logs_exports" {
    description = "Set of log types to export to cloudwatch."
    type        = set(string)
    default     = []
}

#################################################
## Maintenance Properties
#################################################
variable "allow_major_version_upgrade" {
    description = "Enable to allow major engine version upgrades when changing engine versions."
    type        = bool
    default     = false
}

variable "preferred_maintenance_window" {
    description = "The weekly time range during which system maintenance can occur, in (UTC)."
    type        = string
    default     = null
}

variable "apply_immediately" {
    description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window."
    type        = bool
    default     = false
}

#################################################
## Deletion Protection Properties
#################################################
variable "deletion_protection" {
    description = "Flag to decide if the Neptune Cluster should have deletion protection enabled."
    type        = bool
    default     = false
}

#################################################
# Cluster Parameter Group Configurations
#################################################
variable "create_neptune_cluster_parameter_group" {
  description = "Flag to decide if a new Neptune cluster parameter group should be created"
  type        = bool
  default     = false
}

variable "neptune_cluster_parameter_group" {
  description = <<EOF
The configuration map of the Neptune cluster parameter group

name: (Required) The name of the Neptune cluster parameter group.
family: (Required) The family of the Neptune cluster parameter group
description: (Optional) The description of the Neptune cluster parameter group.
tags: (Optional) A map of tags to assign to the resource.

EOF
  default     = {}
}

variable "neptune_cluster_parameter_group_parameters" {
  description = <<EOF
A list of Neptune parameters map to apply.

Each map should have the following 3 properties:
name: (Required) The name of the Neptune parameter.
value: (Required) The value of the Neptune parameter.
apply_method: (Optional) "immediate", or "pending-reboot" (default).

EOF
  type        = list(map(string))
  default     = []
}

#################################################
# Neptune Parameter Group Configurations
#################################################

variable "create_neptune_parameter_group" {
  description = "Flag to decide if a new Neptune parameter group should be created"
  type        = bool
  default     = false
}

variable "neptune_parameter_group" {
  description = <<EOF
The configuration map of the Neptune parameter group

name: (Required) The name of the Neptune parameter group.
family: (Required) The family of the Neptune parameter group
description: (Optional) The description of the Neptune parameter group.
tags: (Optional) A map of tags to assign to the resource.

EOF
  default     = {}
}

variable "neptune_parameter_group_parameters" {
  description = <<EOF
A list of Neptune parameters map to apply.

Each map should have the following 3 properties:
name: (Required) The name of the Neptune parameter.
value: (Required) The value of the Neptune parameter.
apply_method: (Optional) "immediate", or "pending-reboot" (default).

EOF
  type        = list(map(string))
  default     = []
}

#################################################
## IAM properties
#################################################
variable "iam_roles" {
    description = "A List of ARNs for the IAM roles to associate to the Neptune Cluster."
    type        = list(string)
    default     = []
}

#################################################
## Neptune Instances
#################################################
variable "instance_class" {
    description = "The instance class to use for Neptune Instance."
    type        = string
    default     = null
}

variable "publicly_accessible" {
    description = "Flag to decide if instances are publicly accessible"
    type        = bool
    default     = false
}

variable "auto_minor_version_upgrade" {
    description = "Enable to allow minor engine upgrades utomatically to the Neptune instance during the maintenance window."
    type        = bool
    default     = true
}

variable "instances" {
    description = <<EOF
List of cluster instances map where each entry of the list may have following attributes for the instance to override

name                    : (Required) The identifier for the Neptune instance
instance_class          : (Required) The instance class to use.

availability_zone       : (Optional) The EC2 Availability Zone that the neptune instance is created in.
publicly_accessible     : (Optional) Flag to control if instance is publicly accessible.
                          Default - The one set via instances' common property `publicly_accessible`
promotion_tier          : (Optional) Failover Priority setting on instance level.
                          Default - `0`

auto_minor_version_upgrade: (Optional) Enable to allow minor engine upgrades utomatically to the Neptune instance during the maintenance window.
                            Default - The one set via instances' common property `auto_minor_version_upgrade`
apply_immediately       : (Optional) Specifies whether any instance modifications are applied immediately, or during the next maintenance window.
                          Default- the one set at cluster level via property `apply_immediately`

preferred_maintenance_window: (Optional) The window to perform maintenance in.
                              Default - The one set at cluster lebel via property `preferred_maintenance_window`
tags                    : (Optional) A map of tags to assign to the Neptune Instance.
                          Default - {}
EOF
    default     = []
}

variable "endpoints" {
    description = <<EOF
List of cluster endpoints map where each entry of the list may have following attributes 

identifier      : (Required) The identifier to use for the new endpoint.
type            : (Required) The type of the endpoint. One of: READER, WRITER, ANY.
static_members  : (Optional) List of Neptune instance identifiers that are part of the custom endpoint group.
excluded_members: (Optional) List of Neptune instance identifiers that are not part of the custom endpoint group.
tags            : (Optional) A map of tags to assign to the custom endpoint group. Default - {}

Note: Only one of `static_members` and `excluded_members` can be defined
EOF
    default = []
}

#################################################
## Tags
#################################################
variable "default_tags" {
    description = "A map of tags to assign to all the resources."
    type        = map(string)
    default     = {}
}

variable "cluster_tags" {
    description = "A map of tags to assign to the Neptune cluster."
    type        = map(string)
    default     = {}
}

variable "instance_tags" {
    description = "A map of tags to assign to all the Neptune Instance."
    type        = map(string)
    default     = {}
}