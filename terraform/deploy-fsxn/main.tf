terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.25.0"
    }
  }

}

provider "aws" {
  region = "us-west-2"
}

data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "example" {
  for_each = toset(data.aws_subnets.example.ids)
  id       = each.value
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.example : s.cidr_block]
}

resource "aws_fsx_ontap_file_system" "rvwn-terra-fsxn" {
   storage_capacity = var.size_in_gb
   subnet_ids = [var.fsx_subnets["primarysub"]]
   deployment_type = var.deploy_type
   throughput_capacity = var.throughput_in_MBps
   preferred_subnet_id = var.fsx_subnets["primarysub"]
}


