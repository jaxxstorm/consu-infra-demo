output "addresses" {
  value = ["${digitalocean_droplet.prometheus.*.ipv4_address}"]
}

output "ids" {
  value = ["${digitalocean_droplet.prometheus.*.id}"]
}

output "names" {
  value = ["${digitalocean_droplet.prometheus.*.name}"]
}
