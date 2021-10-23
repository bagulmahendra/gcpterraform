resource "google_compute_instance_from_machine_image" "tpl" {
  provider = google-beta
  name     = "mvcdotnet-vm-image"
  zone     = "us-central1-a"

  source_machine_image = "projects/clean-circle-322216/global/machineImages/mvcdotnet-vm-image"

network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  

  labels = {
    app = "mvcdotnet"
  }
}

resource "google_compute_firewall" "http-server" {
  name    = "default-allow-http-terraform-mvcdotnet"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80","3000"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
} 