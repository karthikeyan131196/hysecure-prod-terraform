#########################
# NETWORK CONFIGURATION
#########################

vpc_cidr          = "10.10.0.0/16"
subnet_az1a_cidr  = "10.10.1.0/24"
subnet_az1b_cidr  = "10.10.2.0/24"

#########################
# EC2 CONFIGURATION
#########################

instance_type   = "t3.micro"
root_volume_size = 65

key_pair_name = "hysecure-key"

#########################
# OPTIONAL TAG
#########################

project_name = "hysecure-prod"
