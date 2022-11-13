output "cluster_arn" {
    description = "Neptune Cluster Amazon Resource Name (ARN)"
    value = var.create_cluster ? aws_neptune_cluster.this[0].arn : ""
}

output "port" {
    description = "Database port"
    value = var.create_cluster ? aws_neptune_cluster.this[0].port : ""
}

output "neptune_subnet_group" {
    description = "Neptune Subnet Group Details"
    value = var.create_cluster && var.create_neptune_subnet_group ? {
                                            id = aws_neptune_subnet_group.this[0].id
                                            arn = aws_neptune_subnet_group.this[0].arn
                                          } : {}
}

output "instances" {
    description = "Neptune Cluster Instances"
    value = { for key, value in aws_neptune_cluster_instance.this: 
                    key => {
                            id = value.id
                            arn = value.arn
                            address = value.address
                            endpoint = value.endpoint
                            writer = value.writer
                        }}
}

output "cluster_endpoint" {
    description = "Neptune Cluster Endpint"
    value = var.create_cluster ? aws_neptune_cluster.this[0].endpoint : ""
}

output "cluster_reader_endpoint" {
    description = "Neptune Cluster Read only Endpint; automatically load-balanced across replicas"
    value = var.create_cluster ? aws_neptune_cluster.this[0].reader_endpoint : ""
}

output "custom_endpoints" {
    description = "Neptune Cluster Custom Endpints"
    value = { for key, value in aws_neptune_cluster_endpoint.this: 
                    key => {
                            id = value.id
                            arn = value.arn
                            endpoint = value.endpoint
                        }}
}

output "sg_id" {
    description = "The Security Group ID associated to Neptune"
    value = var.create_sg ? module.neptune_security_group[0].security_group_id : ""
}