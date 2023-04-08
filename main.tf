## Security Group for Neptune
module "neptune_security_group" {
    source = "git::https://github.com/ankit-jn/terraform-aws-security-groups.git"

    count = var.create_sg ? 1 : 0

    vpc_id = var.vpc_id
    name = local.sg_name

    ingress_rules = concat(local.sg_ingress_rules, local.sg_ingress_rules_source_sg)
    egress_rules  = local.sg_egress_rules

    tags = merge({"Name" = local.sg_name}, 
                    { "NeptuneCluster" = var.cluster_name }, var.default_tags)
}
