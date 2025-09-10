data "google_compute_image" "dlvm" {
  family  = "common-cu128-ubuntu-2204-nvidia-570"
  project = "deeplearning-platform-release"
}

resource "google_compute_instance" "af3" {
  name         = "af3"
  machine_type = "g2-standard-16"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = data.google_compute_image.dlvm.self_link
      size  = 3072
      type  = "pd-balanced"
    }
  }


  network_interface {
    network = "default"
  }

  scheduling {
    on_host_maintenance = "TERMINATE"
  }


  metadata_startup_script = file("${path.module}/../scripts/setup.sh")
}
