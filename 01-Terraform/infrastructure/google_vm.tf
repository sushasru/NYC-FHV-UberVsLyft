/*resource "google_service_account" "dtc-de-gcs-SA"{
    account_id = "dtc-de-nyctlc-susha"
    display_name="dtc-de-NYCTLC-Susha"
}*/

resource "google_compute_instance" "nyc-fhvhvvm" {
  name         = var.instance_name
  machine_type = "n1-standard-4"
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

  resource "google_compute_firewall" "allow_ssh" {
  name          = "allow-ssh"
  network       = google_compute_network.vpc_network.name
  target_tags   = ["allow-ssh"] // this targets our tagged VM
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

}