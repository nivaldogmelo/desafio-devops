provider "google" {
  project     = "desafio-globo-330323"
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
    }
  }

  metadata = {
    ssh-keys= "ansible:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJdILTA3DFea0ukS2Gxk8k2cLW8eLSdLr5NokJECCrjlSw7Mp2lmMBrt2ZsH2Ofh2nyJmVb1WiUfhK5dITlam7UCn8gbTFHHAb1DtT4dw2BkAGRo/mFv4F8Szir4G9/DdXqa816uLkPsV7M0cFVmUmyWOqu0b0t88BJjKqPBG5TBOtRbGiut45ilfq25X27uq6Vz995Gank6Q87CxGVE0hz85IGeaTNWOr80U8CbWrgP3lmhtYG3xiODd4OxCAp2dUxdUUlUKhHoSMggga2W+F/VxTnGmzinAStjUARr8macCHssMu8tmCOymztdn/KCfHGcLSyGlS//D8P7IhpA3Xr92yBoAA4kGxSX7/aI18WCZnckz0+0Nrj3gixcHwUEC74TEG3jSyOK57QDwMkVUJawNPOCma2GlFcRc1mOBi71/jGKdlBRmjDPBScI5NXZWHQgJ9L1dTGffjlWvmCJtr/JyIamlX8oYQYTLAp7Dt84/q+C5phRXnGwSRwb1XIb8= ansible"
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

  source_tags = ["web"]
}
