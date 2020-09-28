// instance the provider
provider "libvirt" {
  uri = "qemu:///system"
  //  uri = "qemu:///session"
}

// We fetch the latest ubuntu release image from their mirrors
resource "libvirt_volume" "base-image" {
  name = "base-image"
  source=var.infra-os-base-url
  format = "qcow2"
  pool = var.kvm_pool
}

data "template_file" "user_data" {
  count = length(var.infra-nodes)
  template = "${file("${path.module}/cloudinit_user.cfg")}"
    vars = {
    Domain = var.infra-network-domain
    Hostname = "${lookup(var.infra-nodes[count.index], "nodename")}"
  }
}

data "template_file" "network_config" {
  count = length(var.infra-nodes)
  template = file("${path.module}/cloudinit_net_${lookup(var.infra-nodes[count.index], "net_type")}.cfg")
  vars = {
    Domain = var.infra-network-domain
    NameServer = var.infra-network-nameserver
    Gateway = var.infra-network-gateway
    IPAddress = lookup(var.infra-nodes[count.index], "nodeip_with_mask")
  }
}

resource "libvirt_volume" "system" {
    base_volume_id = libvirt_volume.base-image.id
    name = "${lookup(var.infra-nodes[count.index], "nodename")}.qcow2"
    count = length(var.infra-nodes)
    pool = var.kvm_pool
    size = lookup(var.infra-nodes[count.index], "sysdisk_in_gb") * 1024 * 1024 * 1024
    format = "qcow2"
}

resource "libvirt_volume" "data" {
    name = "${lookup(var.infra-nodes[count.index], "nodename")}-data.qcow2"
    count = length(var.infra-nodes)
    size = lookup(var.infra-nodes[count.index], "datadisk_in_gb") * 1024 * 1024 * 1024
    pool = var.kvm_pool
    format = "qcow2"
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  name = "${lookup(var.infra-nodes[count.index], "nodename")}-cloudinit.iso"
  count = length(var.infra-nodes)
  user_data = data.template_file.user_data[count.index].rendered
  network_config =  data.template_file.network_config[count.index].rendered
  pool = var.kvm_pool
}

resource "libvirt_network" "vm_network"{
  name = var.infra-network-name
  addresses = var.infra-network-subnet
  dhcp {
    enabled = true
  }
}

resource "libvirt_domain" "instance" {

    name = lookup(var.infra-nodes[count.index], "nodename")
    memory = lookup(var.infra-nodes[count.index], "mem_in_gb") * 1024
    vcpu = lookup(var.infra-nodes[count.index], "vcpu")

  network_interface {
    network_id = var.infra-network-bridge == false ? libvirt_network.vm_network.id : null
    network_name = var.infra-network-bridge == "internal" ? var.infra-network-name : null
    bridge = var.infra-network-bridge == false ? null : var.kvm_bridge_interface

    wait_for_lease = lookup(var.infra-nodes[count.index], "net_type") == "dhcp" ? true : false

  }

/* FILE
  provisioner "file" {
    connection {
      type     = "ssh"
      user     = "provision"
      host_key = "provision"
      host     = "${var.host}"
    }
    source      = "testfile.txt"
    destination = "/tmp/testfile.conf"
  }
*/

/* NETWORK 
  network_interface {
        network_id = libvirt_network.vm_network.id
        network_name = var.infra-network-name
        wait_for_lease = var.infra-network-type == "dhcp" ? true : false
    }
*/
  //network_interface { bridge = var.kvm_bridge_interface }

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

/* REMOTE-EXEC
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "provision"
      password = "${var.root_password}"
      host     = var.infra-network-addresses[count.index]
      private_key = file("${path.module}/provision")
    }
    inline = ["sudo hostnamectl set-hostname ${var.infra-node-names[count.index]}"]
  }
*/

/*  LOCAL-EXEC
  provisioner "local-exec" {
    command = "virsh --connect=$SERVER domifaddr --domain  $NODE --source agent | awk '!/^ -|^ lo|-| Name/ {print $4}' >$NODE.ip"
      environment = {
      SERVER = "qemu:///system"
      NODE = "${lookup(var.infra-nodes[count.index], "nodename")}"
    }
  }
*/

  count = length(var.infra-nodes)

}

output "ips" {
  value = libvirt_domain.instance.*.network_interface.0.addresses
}

terraform {
  required_version = ">= 0.12"
}
