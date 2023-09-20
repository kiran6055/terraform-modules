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

variable "private_subnet_names" {
  type = list
}

variable "database_subnet_names" {
  type = list
}

variable "public_subnet_tags" {
  type = map
  default = {}
}


variable "private_subnet_tags" {
  type = map
  default = {}
}


variable "database_subnet_tags" {
  type = map
  default = {}
}


variable "database_subnet_group_tags" {
  type = map
  default = {}
}

variable "igw_tag" {
  type = map
  default = {}
}

# for the PublicRT & PrivateRT_tags #DatabaseRT_tags we have used concatfunction in loals.tf in timinginfra
 variable "PublicRT_tags" {
 }

 variable "PrivateRT_tags" {
} 

variable "databaseRT_tags" {
  }
