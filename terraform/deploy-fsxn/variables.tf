variable "vpc_id" {
   type = string
   default = "vpc-06df8175c83fa34d3"
}

variable "fsx_subnets" {
   type = map
   default = {
      "primarysub" = "subnet-0363569f91f7bac2d"
      "secondarysub" = "subnet-0ad787406f660bcbb"
   }
}

variable "size_in_gb" {
   type = string
   default = "1024"
}

variable "deploy_type" {
   type = string 
   default = "SINGLE_AZ_1"
}
       
variable "throughput_in_MBps" {
   type = string
   default = "128"
}



