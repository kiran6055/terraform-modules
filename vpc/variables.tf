variable "vpc_cidr" {
  type = string
}

variable "public_cidr" {
  type = string
}

variable "private_cidr" {
  type = string
}

variable "database_cidr" {
  type = string
}


variable "tags" {
  type = map
  default = {
   Name = "roboshop"
   ENV  = "DEV"
   TERRAFORM = "true"
  }
}


variable "publicsubnet_tags" {
  type = map
  default = {
   Name = "public"
   ENV  = "DEV"
   TERRAFORM = "true"
  }
}


variable "privatesubnet_tags" {
  type = map
  default = {
   Name = "private"
   ENV  = "DEV"
   TERRAFORM = "true"
  }
}


variable "databasesubnet_tags" {
  type = map
  default = {
   Name = "database"
   ENV  = "DEV"
   TERRAFORM = "true"
  }
}

variable "PublicRT_tags" {
  type = map
  default = {
   Name = "roboshop-PUBLIC"
   ENV  = "DEV"
   TERRAFORM = "true"
  }
}

variable "PrivateRT_tags" {
  type = map
  default = {
   Name = "roboshop-Private"
   ENV  = "DEV"
   TERRAFORM = "true"
  }
}