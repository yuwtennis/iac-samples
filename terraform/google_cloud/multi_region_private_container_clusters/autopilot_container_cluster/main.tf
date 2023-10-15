// This is a module for deploying autopilot container cluster
// which will be provisioned to a private network.
//
// https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster#example-usage---with-the-default-node-pool
locals {
  // Constants
  create_timeout = "30m"
  update_timeout = "40m"
}

// Cluster topology based on doc
// https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters#auto_subnet
resource "google_container_cluster" "cluster" {
  name               = var.cluster_name
  location           = var.location
  initial_node_count = var.default_num_of_nodes
  enable_autopilot   = true
  network            = var.network_self_link
  subnetwork         = var.subnetwork_self_link

  // Private cluster configuration
  // https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.allowed_master_access_cidrs
      content {
        cidr_block = cidr_blocks.value
      }
    }
  }

  node_config {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.node_config["service_account_email"]
    oauth_scopes    = var.node_config["oauth_scopes"]
    machine_type    = var.node_config["machine_type"]
    disk_type       = var.node_config["disk_type"]
    disk_size_gb    = var.node_config["disk_size_gb"]
  }
  timeouts {
    create = local.create_timeout
    update = local.update_timeout
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pod_range_name
    services_secondary_range_name = var.service_range_name
  }
}