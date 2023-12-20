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

resource "aws_fsx_ontap_file_system" "rvwn-terra-fsxn" {
   storage_capacity = var.size_in_gb
   subnet_ids = [var.fsx_subnets["primarysub"]]
   deployment_type = var.deploy_type
   throughput_capacity = var.throughput_in_MBps
   preferred_subnet_id = var.fsx_subnets["primarysub"]
   tags = {
	Name = "rvwn-fsx1"
   }
}

resource "aws_fsx_ontap_storage_virtual_machine" "mysvm" {
  file_system_id = aws_fsx_ontap_file_system.rvwn-terra-fsxn.id
  name           = var.svm_name
}

resource "aws_fsx_ontap_volume" "myvol" {
  name                       = var.vol_info["vol_name"]
  junction_path              = var.vol_info["junction_path"]
  size_in_megabytes          = var.vol_info["size"]
  storage_efficiency_enabled = var.vol_info["efficiency"]
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.mysvm.id

  tiering_policy {
    name           = var.vol_info["tier_policy_name"]
    cooling_period = var.vol_info["cooling_period"]
  }
}


