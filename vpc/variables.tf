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