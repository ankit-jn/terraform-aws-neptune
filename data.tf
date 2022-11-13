## Data source of KMS Key
data aws_kms_key "this" {
    count = var.kms_key != null ? 1 : 0

    key_id = var.kms_key
}