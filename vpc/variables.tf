variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = list
}

variable "private_subnet_cidr" {
  type = list
}

variable "database_subnet_cidr" {
  type = list
}


variable "tags" {
  type = map
}


variable "vpc_tags" {
  type = map
  default = {}
}


variable "azs" {
  type = list
}

variable "public_subnet_names" {
  type = list
}

variable "public_subnet_tags" {
  type = map
}


variable "private_subnet_tags" {
  type = map
}


variable "database_subnet_tags" {
  type = map
  default = {}
}

variable "PublicRT_tags" {
  type = map   
}

variable "PrivateRT_tags" {
  type = map
}