# variable "cidr" {
#   type = string
#   default = "10.0.1.0/16"
#   }

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
   Name = "roboshop-public"
   ENV  = "DEV"
   TERRAFORM = "true"
  }
}


variable "privatesubnet_tags" {
  type = map
  default = {
   Name = "roboshop-private"
   ENV  = "DEV"
   TERRAFORM = "true"
  }
}


variable "databasesubnet_tags" {
  type = map
  default = {
   Name = "roboshop-database"
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