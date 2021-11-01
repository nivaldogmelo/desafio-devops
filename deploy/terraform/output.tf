output "comment_api_ip" {
  value       = google_compute_instance.comment_api.network_interface.0.access_config.0.nat_ip
  description = "The VM machine external IP"
}
