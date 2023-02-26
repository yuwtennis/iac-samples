
variable "cluster_name" {
  type    = string
  default = null
}

variable "location" {
  type        = string
  description = "Accepts either region or zone name"
}

variable "default_num_of_nodes" {
  type    = string
  default = 1
}

variable "allowed_master_access_cidrs" {
  type = map(any)
  default = {
    home = "127.0.0.1/32"
  }
}

variable "network_self_link" {
  type = string
}

variable "subnetwork_self_link" {
  type = string
}

variable "node_config" {
  type = object({ service_account_email = string, oauth_scopes = list(string) })
  default = {
    service_account_email = "admin@localhost.localdomain"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

variable "pod_range_name" {
  type    = string
  default = null
}

variable "pod_ipv4_cidr_block" {
  type    = string
  default = null
}

variable "service_range_name" {
  type    = string
  default = null
}

variable "service_ipv4_cidr_block" {
  type    = string
  default = null
}