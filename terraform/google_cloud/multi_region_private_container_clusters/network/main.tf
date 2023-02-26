resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  description             = ""
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "primary" {
  name          = var.subnet_name
  region        = var.subnet_region
  ip_cidr_range = var.subnet_primary_cidr
  dynamic secondary_ip_range {
    for_each = var.secondary_ip_ranges
    content {
      ip_cidr_range = secondary_ip_range.value
      range_name = secondary_ip_range.key
    }
  }
  network       = google_compute_network.vpc.id
}

# nat
resource "google_compute_router" "router" {
  name    = "my-router"
  region  = google_compute_subnetwork.primary.region
  network = google_compute_network.vpc.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
