variable "s3_tf_state_bucket_name" {
  description = "S3 bucket name to use with TF state (globally unique)"
  type        = string
  default     = "sc-infra-tf-state-bucket-dev"
}

variable "account_id" {
  description = "AWS Account Id"
  type        = string
  default     = "000000000000"
}
variable "region" {
  description = "AWS region for deployment"
  type        = string
  default     = "eu-west-1"
}

variable "environment" {
  description = "Environment name (e.g. dev/qa/prd)"
  type        = string
  default     = "dev"
}
