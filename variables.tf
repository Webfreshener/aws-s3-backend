variable "region" {
  description = "AWS Deployment Region for the backend s3 bucket"
  type = "string"
}

variable "profile" {
  description = "AWS Credential Profile Name for Access"
  type = "string"
}

variable "prefix" {
  description = "AWS Resource Naming Prefix"
  type = "string"
}
