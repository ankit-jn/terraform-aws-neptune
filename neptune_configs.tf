## Neptune Subnet Group
resource aws_neptune_subnet_group "this" {
    count = var.create_cluster && var.create_neptune_subnet_group ? 1 : 0
    
    name        = coalesce(var.neptune_subnet_group_name, format("%s-default", var.cluster_name))
    description = format("Neptune subnet group for Neptune cluster - %s", var.cluster_name)
    
    subnet_ids  = var.subnets

    tags = var.default_tags
}

## Neptune Cluster Parameter Group
resource aws_neptune_cluster_parameter_group "this" {
    count = var.create_cluster && var.create_neptune_cluster_parameter_group ? 1 : 0

    name        = var.neptune_cluster_parameter_group.name
    description = lookup(var.neptune_cluster_parameter_group, "description", var.db_cluster_parameter_group.name)
    family      = var.neptune_cluster_parameter_group.family

    dynamic "parameter" {
      for_each = var.neptune_cluster_parameter_group_parameters

      content {
        name         = parameter.value.name
        value        = parameter.value.value
        apply_method = try(parameter.value.apply_method, "pending-reboot")
      }
    }

    tags = merge(var.default_tags, lookup(var.neptune_cluster_parameter_group, "tags", {}))
}

## Neptune Parameter Group
resource aws_neptune_parameter_group "this" {
    count = var.create_cluster && var.create_neptune_parameter_group ? 1 : 0

    name        = var.neptune_parameter_group.name
    description = lookup(var.neptune_parameter_group, "description", var.neptune_parameter_group.name)
    family      = var.neptune_parameter_group.family

    dynamic "parameter" {
      for_each = var.neptune_parameter_group_parameters

      content {
        name         = parameter.value.name
        value        = parameter.value.value
        apply_method = try(parameter.value.apply_method, "pending-reboot")
      }
    }

    tags = merge(var.default_tags, lookup(var.neptune_parameter_group, "tags", {}))
}