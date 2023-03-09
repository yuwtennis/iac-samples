
module "nw_blue" {
  source              = "./network"
  vpc_name            = "nw-blue"
  subnet_name         = "nw-blue-subnet-0"
  subnet_region       = var.region_blue
  subnet_primary_cidr = var.nw_blue_primary_ipv4_cidr_range
  secondary_ip_ranges = {
    (var.nw_blue_pod_ipv4_cidr_range["name"])     = var.nw_blue_pod_ipv4_cidr_range["range"]
    (var.nw_blue_service_ipv4_cidr_range["name"]) = var.nw_blue_service_ipv4_cidr_range["range"]
  }
}

module "nw_green" {
  count               = var.multi_region_enabled == true ? 1 : 0
  source              = "./network"
  vpc_name            = "nw-green"
  subnet_name         = "nw-green-subnet-0"
  subnet_region       = var.region_green
  subnet_primary_cidr = var.nw_green_primary_ipv4_cidr_range
  secondary_ip_ranges = {
    (var.nw_green_pod_ipv4_cidr_range["name"])     = var.nw_green_pod_ipv4_cidr_range["range"]
    (var.nw_green_service_ipv4_cidr_range["name"]) = var.nw_green_service_ipv4_cidr_range["range"]
  }
}
