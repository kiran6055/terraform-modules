variable "vpc_cidr" {
  type = string
}

variable "public_cidr" {
  type = list
}

variable "private_cidr" {
  type = list
}

variable "database_cidr" {
  type = list
}


variable "tags" {
  type = map
}


variable "vpc_tags" {
  type = map
  default = {}
}



variable "publicsubnet_tags" {
  type = map
}


variable "privatesubnet_tags" {
  type = map
}


variable "databasesubnet_tags" {
  type = map
}

variable "PublicRT_tags" {
  type = map   
}

variable "PrivateRT_tags" {
  type = map
}