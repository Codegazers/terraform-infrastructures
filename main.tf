// instance the provider
provider "libvirt" {
  uri = "qemu:///system"
}

// We fetch the latest ubuntu release image from their mirrors
resource "libvirt_volume" "base-image" {
  name = "base-image"
  source = "https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64.img"
  //source = "/var/lib/libvirt/images/bionic-server-cloudimg-amd64.img"
  format = "qcow2"
  pool = var.kvm_pool
}

data "template_file" "user_data" {
  template = "${file("${path.module}/cloudinit_user.cfg")}"
}

data "template_file" "network_config" {
  count = length(var.infra-node-names)
  template = file("${path.module}/cloudinit_net_${var.infra-network-type}.cfg")
  vars = {
    Domain = var.infra-network-domain
    NameServer = var.infra-network-nameserver
    Gateway = var.infra-network-gateway
    IPAddress = var.infra-network-addresses[count.index]
  }
}


resource "libvirt_network" "vm_network"{
    name = var.infra-network-name
    addresses = var.infra-network-subnet
        dhcp {
            enabled = true
        }
}


resource "libvirt_volume" "system" {
    name = "${var.infra-node-names[count.index]}.qcow2"
    count = length(var.infra-node-names)
    pool = var.kvm_pool
    source = "https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64.img"
    format = "qcow2"
}

resource "libvirt_volume" "data" {
    name = "${var.infra-node-names[count.index]}-data.qcow2"
    count = length(var.infra-node-names)
    size = 26843545600
    pool = var.kvm_pool
    format = "qcow2"
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  name = "${var.infra-node-names[count.index]}-cloudinit.iso"
  count = length(var.infra-node-names)
  user_data = data.template_file.user_data.rendered
  network_config =  data.template_file.network_config[count.index].rendered
  pool = var.kvm_pool
}

resource "libvirt_domain" "instance" {

    name = element(var.infra-node-names, count.index)
    memory = var.infra-node-memory
    vcpu = var.infra-node-vcpu

    /*network_interface {
        bridge = "${var.kvm_bridge_interface}"
    }*/

    network_interface {
        network_id = libvirt_network.vm_network.id
        network_name = var.infra-network-name
        //wait_for_lease = true
    }

  /* IMPORTANT
   Ubuntu can hang is a isa-serial is not present at boot time.
   If you find your CPU 100% and never is available this is why */
    console {
        type        = "pty"
        target_port = "0"
        target_type = "serial"
    }

    console {
        type        = "pty"
        target_type = "virtio"
        target_port = "1"
    }


    cloudinit = libvirt_cloudinit_disk.cloudinit[count.index].id
    disk {
        volume_id = libvirt_volume.system[count.index].id
    }

    disk {
        volume_id = libvirt_volume.data[count.index].id
    }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = "true"
  }
  count = length(var.infra-node-names)

}

output "ips" {
  value = libvirt_domain.instance.*.network_interface.0.addresses
}

terraform {
  required_version = ">= 0.12"
}
