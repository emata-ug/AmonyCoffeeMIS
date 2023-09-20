#Create Droplet 
resource "digitalocean_droplet" "www-1" {
    image = "ubuntu-20-04-x64"
    name = "AmonyCoffeeMIS"
    region = "nyc3"
    size = "s-1vcpu-1gb"
    ssh_keys = [
      data.digitalocean_ssh_key.terraform.id
    ]
}
# Create Project
resource "digitalocean_project" "AmonyCoffeeMIS" {
  name        = "AmonyCoffeEMIS"
  description = "A project for AmonyCoffeEMIS resources."
  purpose     = "Web Application"
  environment = "Production"
  resources   = [digitalocean_droplet.www-1.urn]
}

#Add domain
resource "digitalocean_domain" "default" {
   name = var.domain_name
   ip_address = digitalocean_droplet.www-1.ipv4_address
}

resource "digitalocean_record" "main-record" {
  domain = digitalocean_domain.default.name
  type = "A"
  name = "AmonyCoffeeMIS"
  value = digitalocean_droplet.www-1.ipv4_address
}