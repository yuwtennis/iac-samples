variable "vpc_name" {
  type = string
  default = "my-network"
}

variable "subnet_name" {
  type = string
  default = "my-subnet"
}

variable "subnet_region" {
  type = string
  default = null
}

variable "subnet_primary_cidr" {
  type = string
  default = "192.168.0.0/20"
}

variable "secondary_ip_ranges" {
  type = map(string)
  default = {
    my-pods = "10.4.0.0/14"
    my-services = "10.0.32.0/20"
  }
}