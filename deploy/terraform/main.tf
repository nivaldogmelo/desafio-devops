provider "google" {
  project = "desafio-globo-330323"
}

resource "google_compute_instance" "comment_api" {
  name         = "api-comment"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  tags = ["comment-api"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
      nat_ip = "34.123.248.117"
    }
  }

  metadata = {
    ssh-keys = "ansible:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDo6OtxkrVGVq6NVY5nZaF5oobmosoDADtyy+pgNgzYUqCvcHz6PnLCUXj53Sh/EvXwLfLXwx8k4nlA4hcEUAmn4JlRQqElhZoVE7qB/1mSGPOQEVIvUjmAWbDI7lHnxFuvmq/laHkDfdJqLJ/uqRSX6JSDRPb8FtYC0oonRQB0lQySgj/J94rOgW6gIrQH1GaPtUKoLcRRgQjb4lOegilDHkGhR32BVMaRnnT3WDV29Bns3Yk956TS6NbPDyXaGT7VXzn7v7RcBJDZbp588F5xQXkKFPFjE4t5O2YDi6iNIcQSkk8NT024OD/+dnZP3p/BASuTWnJF0lE3zCg5b6iD2Ov+nehF/xsDIuwkIT4Z52M9+z2qm/wPGdQ9WYKSDuaoAHEeWpEYThzLMufk2+vfeFtTbtDEEeXcL2urnP9/qpUPIozB5/G+RfZ7WiK6s+PTVzueqfBkht5lqyxTpsQ7L+IiI5tDZM38HHM8KFEqQS/V+HG4smPemZ+sbSJiWe0= ansible"
  }
}


resource "google_compute_firewall" "comment_api" {
  name    = "comment-api"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["8000", "3000"]
  }

  source_tags = ["comment-api"]
}
