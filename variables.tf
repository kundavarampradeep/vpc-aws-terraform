variable "cidr_block" {
    default = {}
}

variable "enable_dns_support" {
    default = true
}

variable "enable_dns_hostnames" {
    default = true
}

variable "common_tags" {
    default = {}
    type = map
}

variable "vpc_tags" {
    default = {}
    type = map
}

variable "igw_tags" {
    default = {}
}

variable "public_subnet_cidr" {
  
}

variable "azs" {
  
}

variable "public_subnet_names" {
  
}

variable "private_subnet_cidr" {
  
}

variable "private_subnet_names" {
  
}

variable "data_base_subnet_cidr" {
  
}

variable "data_base_subnet_names" {
  
}

variable "public_route_table_tags" {
  
}

variable "private_route_table_tags" {
  
}

variable "data_base_route_table_tags" {
  
}