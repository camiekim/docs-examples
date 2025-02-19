resource "google_compute_region_disk" "primary" {
  provider = google-beta

  name                      = "primary-region-disk-${local.name_suffix}"
  type                      = "pd-ssd"
  region                    = "us-central1"
  physical_block_size_bytes = 4096

  replica_zones = ["us-central1-a", "us-central1-f"]
}

resource "google_compute_region_disk" "secondary" {
  provider = google-beta

  name                      = "secondary-region-disk-${local.name_suffix}"
  type                      = "pd-ssd"
  region                    = "us-east1"
  physical_block_size_bytes = 4096

  async_primary_disk {
    disk = google_compute_region_disk.primary.id
  }

  replica_zones = ["us-east1-b", "us-east1-c"]
}
