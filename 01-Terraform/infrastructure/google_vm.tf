resource "google_service_account" "dtc-de-gcs-SA"{
    account_id = "dtc-de-nyctlc-susha"
    display_name="dtc-de-NYCTLC-Susha"
}

resource "google_compute_instance" "dtc-de-NYCTLC-Susha" {
  name         = "nyc-fhvhv"
  machine_type = "e2-standard-4"
  zone         = var.google_region

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20230302"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

}