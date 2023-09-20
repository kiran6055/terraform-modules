locals {
  cidr = "10.0.0.0/16"
}

locals {
  public_cidr = "10.0.1.0/24"
}

locals {
  private_cidr = "10.0.2.0/24"
}

locals {
  database_cidr = "10.0.3.0/24"
}

locals {
  azs = ["ap-south-1b","ap-south-1c"]
}