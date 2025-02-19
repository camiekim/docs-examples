resource "google_compute_resource_policy" "cgroup" {
  provider = google-beta

  name   = "gce-policy-${local.name_suffix}"
  region = "europe-west1"
  disk_consistency_group_policy {
    enabled = true
  }
}
