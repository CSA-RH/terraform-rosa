variable "aws_region" {
    default = "us-east-2"
    description   = "AWS region where to deploy."
    type = string
}

variable "env_name" {
    default = "rosa-test-env"
    description   = "Environment name"
    type = string
}

variable "availability_zones" {
    default = ["us-east-2a"]
    type = list(string)
}


variable "egress_env_name" {
    default = "rosa-egressenv"
    description   = "Environment name"
    type = string
}

variable "cluster_owner_tag" {
    default = "infra-team"
    description   = "Cluster owner name to tag resources"
    type = string
}

variable "environment" {
    default = "Development"
    description   = "Environment name"
    type = string
}


variable "cluster_cidr" {
    default = "10.1.0.0/16"
    description   = "ROSA VPC CIDR"
}

variable "egress_vpc_cidr" {
    default = "10.0.0.0/16"
    description   = "Egress VPC CIDR"
}

variable "tgw_cidr_block" {
  type        = string
  default     = "10.1.0.0/16"
  description = "cidr range that should be used for tgw"
}