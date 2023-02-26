# This is a root module which bootstrap cluster with default node pool
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster#example-usage---with-the-default-node-pool

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.54.0"
    }
  }
}

provider "google" {
  project = var.project
}

resource "google_service_account" "container_cluster_op_account" {
  account_id   = "container-cluster-op-account"
  display_name = "Service Account specifically used for cluster workload"
}
