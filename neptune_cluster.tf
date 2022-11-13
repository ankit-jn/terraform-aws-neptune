## Neptune Cluster
resource aws_neptune_cluster "this" {

    count = var.create_cluster ? 1 : 0

    ## Engine options
    engine          = var.engine
    engine_version  = var.engine_version

    cluster_identifier  = var.cluster_name
    
    ## Availability & durability
    availability_zones  = var.availability_zones

    ## Connectivity
    port                    = coalesce(var.db_port, 8182)
    neptune_subnet_group_name    = var.create_neptune_subnet_group ? aws_neptune_subnet_group.this[0].name : coalesce(var.neptune_subnet_group_name, "default")
    vpc_security_group_ids  = local.security_groups

    iam_roles = var.iam_roles
    
    ## Database authentication
    iam_database_authentication_enabled = var.iam_database_authentication_enabled

    ## Additional configuration
    neptune_cluster_parameter_group_name   = var.create_neptune_cluster_parameter_group ? aws_neptune_cluster_parameter_group.this[0].id : lookup(var.neptune_cluster_parameter_group, "name", null)
    
    ## Backup
    backup_retention_period   = var.backup_retention_period
    copy_tags_to_snapshot     = var.copy_tags_to_snapshot
    preferred_backup_window   = var.preferred_backup_window
    snapshot_identifier       = var.snapshot_identifier
    skip_final_snapshot       = var.skip_final_snapshot
    final_snapshot_identifier = !var.skip_final_snapshot ? var.final_snapshot_identifier : null
    
    ## Encryption
    storage_encrypted = var.storage_encrypted
    kms_key_arn       = (var.kms_key != null) ? data.aws_kms_key.this[0].arn : null

    ## Log Exports
    enable_cloudwatch_logs_exports = var.enable_cloudwatch_logs_exports

    ## Maintenance
    allow_major_version_upgrade   = var.allow_major_version_upgrade
    preferred_maintenance_window  = var.preferred_maintenance_window
    apply_immediately             = var.apply_immediately

    ## Deletion Protection
    deletion_protection = var.deletion_protection

    tags = merge({"Name" = var.cluster_name}, var.default_tags, var.cluster_tags)

    depends_on = [
        aws_neptune_subnet_group.this
    ]
}