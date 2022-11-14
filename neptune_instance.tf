## Cluster Instances
resource aws_neptune_cluster_instance "this" {

    for_each = { for instance in var.instances:  
                            instance.name => instance if var.create_cluster } 

    identifier = each.key
    cluster_identifier = aws_neptune_cluster.this[0].id

    engine          = var.engine
    engine_version  = var.engine_version
    instance_class  = lookup(each.value, "instance_class", var.instance_class)
    
    availability_zone   = lookup(each.value, "availability_zone", null)
    publicly_accessible = lookup(each.value, "publicly_accessible", var.publicly_accessible)
    promotion_tier      = lookup(each.value, "promotion_tier", 0)

    neptune_subnet_group_name    = var.create_neptune_subnet_group ? aws_neptune_subnet_group.this[0].name : coalesce(var.neptune_subnet_group_name, "default")
    neptune_parameter_group_name = var.create_neptune_parameter_group ? aws_neptune_parameter_group.this[0].id : lookup(var.neptune_parameter_group, "name", null)

    auto_minor_version_upgrade  = lookup(each.value, "auto_minor_version_upgrade", var.auto_minor_version_upgrade)
    apply_immediately           = lookup(each.value, "apply_immediately", var.apply_immediately)

    preferred_maintenance_window = lookup(each.value, "preferred_maintenance_window", var.preferred_maintenance_window)

    tags = merge({"Name" = each.key}, 
                    { "NeptuneCluster" = var.cluster_name }, 
                    var.default_tags, 
                    var.cluster_tags, 
                    var.instance_tags, lookup(each.value, "tags", {}))
}

## Cluster Endpoint(s)
resource aws_neptune_cluster_endpoint "this" {

    for_each = { for endpoint in var.endpoints: 
                            endpoint.identifier => endpoint if var.create_cluster } 

    cluster_endpoint_identifier = each.key
    endpoint_type        = each.value.type
    cluster_identifier          = aws_neptune_cluster.this[0].id

    static_members = can(each.value.static_members) ? flatten([for member in each.value.static_members : aws_neptune_cluster_instance.this[member].id]) : null
    excluded_members = can(each.value.excluded_members) ? flatten([for member in each.value.excluded_members : aws_neptune_cluster_instance.this[member].id]) : null

    tags = merge({"Name" = each.key}, 
                    { "NeptuneCluster" = var.cluster_name }, 
                    var.default_tags, 
                    var.cluster_tags, 
                    lookup(each.value, "tags", {}))

    depends_on = [
        aws_neptune_cluster_instance.this
    ]
}