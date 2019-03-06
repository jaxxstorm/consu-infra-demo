
data "template_file" "prometheus_user_data" {
  template = "${file("${path.module}/templates/prometheus.tpl")}"
  count = "${var.count}"
  vars {
    hostname = "prometheus-${count.index}"
    domain = "${var.digitalocean_domain}"
    fqdn = "prometheus-${count.index}.${var.digitalocean_domain}"
  }
}

resource "digitalocean_droplet" "prometheus" {
  count = "${var.count}"
  image = "centos-7-x64"
  name  = "prometheus-${count.index}"
  region = "${var.digitalocean_region}"
  size = "${var.digitalocean_droplet_size}"
  private_networking = true
  ssh_keys = [ "${var.digitalocean_keys}" ]
  user_data = "${element(data.template_file.prometheus_user_data.*.rendered,count.index)}"
}

resource "digitalocean_record" "prometheus" {
  count  = "${var.count}"
  domain = "${var.digitalocean_domain}"
  type   = "A"
  name   = "prometheus-${count.index}"
  value  = "${element(digitalocean_droplet.prometheus.*.ipv4_address_private, count.index)}"
}

