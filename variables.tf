#########################
# REGION
#########################

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

#########################
# NETWORK VARIABLES
#########################

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "subnet_az1a_cidr" {
  description = "Subnet CIDR for AZ ap-south-1a"
  type        = string
}

variable "subnet_az1b_cidr" {
  description = "Subnet CIDR for AZ ap-south-1b"
  type        = string
}
#########################
# EC2 VARIABLES
#########################

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "root_volume_size" {
  description = "Root volume size (GB)"
  type        = number
}

variable "ami_id" {
  description = "HySecure AMI"
  type        = string
  default     = "ami-0caa6d72e7d3af20d"
}

variable "key_pair_name" {
  description = "Key pair name"
  type        = string
}

#########################
# TAGGING
#########################

variable "project_name" {
  type        = string
  default     = "hysecure"
}
#################################
# Instance AZ Selection
#################################

variable "instance_az_map" {
  description = "Which AZ each instance should be deployed into"

  type = map(string)

  default = {
    active  = "ap-south-1a"
    standby = "ap-south-1b"
    real    = "ap-south-1a"
  }
}
