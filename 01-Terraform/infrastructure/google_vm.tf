/*resource "google_service_account" "dtc-de-gcs-SA"{
    account_id = "dtc-de-nyctlc-susha"
    display_name="dtc-de-NYCTLC-Susha"
}*/

resource "google_compute_instance" "nyc-fhvhv-vm" {
  name         = var.instance_name
  machine_type = "e2-standard-4"
  zone         = var.google_zone

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
  }

}