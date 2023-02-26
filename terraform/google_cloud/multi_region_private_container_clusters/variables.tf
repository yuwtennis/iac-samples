variable "project" {
  type = string
  default = null
}

variable "region_blue" {
  type = string
  default = "us-west1"
}

variable "region_green" {
  type = string
  default = "us-east1"
}

variable "allowed_master_access_cidrs" {
  type = map(any)
  default = null
}

# Subnet examples are referenced from online doc
# https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters#custom_subnet
variable "nw_blue_primary_ipv4_cidr_range" {
  type = string
  default = "192.168.0.0/20"
}

variable "nw_blue_pod_ipv4_cidr_range" {
  type = map(string)
  default = {
    name = "pods"
    range = "10.4.0.0/14"
  }
}

variable "nw_blue_service_ipv4_cidr_range" {
  type = map(string)
  default = {
    name = "services"
    range = "10.0.32.0/20"
  }
}

variable "nw_green_primary_ipv4_cidr_range" {
  type = string
  default = "192.168.32.0/20"
}

variable "nw_green_pod_ipv4_cidr_range" {
  type = map(string)
  default = {
    name = "pods"
    range = "10.8.0.0/14"
  }
}

variable "nw_green_service_ipv4_cidr_range" {
  type = map(string)
  default = {
    name = "services"
    range = "10.0.64.0/20"
  }
}
