# token
variable "digital_ocean_token" {}

variable "digital_ocean_domain" {}

variable "ssh_public_key" {}

variable "number_of_puppetservers" {}

variable "number_of_databases" {
  default = 2
}

variable "number_of_vaultservers" {
  default = 3
}

provider "digitalocean" {
  token = "${var.digital_ocean_token}"
}

resource "digitalocean_ssh_key" "personal" {
  name       = "personal_key"
  public_key = "${var.ssh_public_key}"
}

resource "digitalocean_domain" "default" {
  name       = "${var.digital_ocean_domain}"
  ip_address = "127.0.0.1"
}

module "puppet_ca" {
  source              = "modules/puppet_ca"
  digitalocean_domain = "${var.digital_ocean_domain}"
  digitalocean_keys   = "${digitalocean_ssh_key.personal.id}"
  digitalocean_region = "sfo2"
}

/*
module "puppetserver" {
  source              = "modules/puppetserver"
  digitalocean_domain = "${var.digital_ocean_domain}"
  digitalocean_keys   = "${digitalocean_ssh_key.personal.id}"
  count               = "${var.number_of_puppetservers}"
  puppet_ca           = ["${module.puppet_ca.name}"]
  digitalocean_region = "sfo2"
}

module "consulserver" {
  source              = "modules/consulserver"
  digitalocean_domain = "${var.digital_ocean_domain}"
  digitalocean_keys   = "${digitalocean_ssh_key.personal.id}"
  puppet_ca           = ["${module.puppet_ca.name}"]
  digitalocean_region = "sfo2"
}

module "vaultserver" {
  source              = "modules/vaultserver"
  digitalocean_domain = "${var.digital_ocean_domain}"
  digitalocean_keys   = "${digitalocean_ssh_key.personal.id}"
  puppet_ca           = ["${module.puppet_ca.name}"]
  count               = "${var.number_of_vaultservers}"
}

module "mysql" {
  source              = "modules/mysql"
  digitalocean_domain = "${var.digital_ocean_domain}"
  digitalocean_keys   = "${digitalocean_ssh_key.personal.id}"
  puppet_ca           = ["${module.puppet_ca.name}"]
  count               = "${var.number_of_databases}"
}
*/

output "puppetca_address" {
  value = "${module.puppet_ca.addresses}"
}

/*

output "puppetserver_addresses" {
  value = "${module.puppetserver.addresses}"
}

output "consulserver_addresses" {
  value = "${module.consulserver.addresses}"
}

output "mysql_addresses" {
  value = "${module.mysql.addresses}"
}

output "vault_addresses" {
  value = "${module.vaultserver.addresses}"
}
*/
