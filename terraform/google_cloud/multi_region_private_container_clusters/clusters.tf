module "blue" {
  source                      = "./autopilot_container_cluster"
  cluster_name                = "blue"
  location                    = var.region_blue
  allowed_master_access_cidrs = var.allowed_master_access_cidrs
  network_self_link           = module.nw_blue.network_self_link
  subnetwork_self_link        = module.nw_blue.subnet_self_link
  node_config = {
    service_account_email = google_service_account.container_cluster_op_account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  pod_range_name          = var.nw_blue_pod_ipv4_cidr_range["name"]
  pod_ipv4_cidr_block     = var.nw_blue_pod_ipv4_cidr_range["range"]
  service_range_name      = var.nw_blue_service_ipv4_cidr_range["name"]
  service_ipv4_cidr_block = var.nw_blue_service_ipv4_cidr_range["range"]
}

module "green" {
  source                      = "./autopilot_container_cluster"
  count                       = var.multi_region_enabled == true ? 1 : 0
  cluster_name                = "green"
  location                    = var.region_green
  allowed_master_access_cidrs = var.allowed_master_access_cidrs
  network_self_link           = module.nw_green[0].network_self_link
  subnetwork_self_link        = module.nw_green[0].subnet_self_link
  node_config = {
    service_account_email = google_service_account.container_cluster_op_account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  pod_range_name          = var.nw_green_pod_ipv4_cidr_range["name"]
  pod_ipv4_cidr_block     = var.nw_green_pod_ipv4_cidr_range["range"]
  service_range_name      = var.nw_green_service_ipv4_cidr_range["name"]
  service_ipv4_cidr_block = var.nw_green_service_ipv4_cidr_range["range"]

}

