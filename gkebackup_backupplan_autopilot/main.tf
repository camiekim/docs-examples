resource "google_container_cluster" "primary" {
  provider = google-beta
  name               = "autopilot-cluster-${local.name_suffix}"
  location           = "us-central1"
  enable_autopilot = true
  ip_allocation_policy {   
  }
  release_channel {
    channel = "RAPID"
  }
  addons_config {
    gke_backup_agent_config {
      enabled = true
    }
  }
}

resource "google_gke_backup_backup_plan" "autopilot" {
  provider = google-beta
  name = "autopilot-plan-${local.name_suffix}"
  cluster = google_container_cluster.primary.id
  location = "us-central1"
  backup_config {
    include_volume_data = true
    include_secrets = true
    all_namespaces = true
  }
}
