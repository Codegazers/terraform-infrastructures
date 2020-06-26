variable "infra-os-base-url" {
  type = string
  default = "https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64.img"
  description = "Infrastructure OS Base Image"
}

variable "private_key_path" {
  type = string
  default = "../keys/provision"
  description = "SSH Private Key"
}

variable "infra-lab" {
  type = string
  default = "lab"
  description = "Infrastructure Environment Name"
}

# variable "infra-node-prefix" {
#   type = string
#   default = "node"
#   description = "Nodes Prefix Names"
# }

# variable "infra-node-count" {
#   default = 2
#   description = "Number of Nodes"
# }

variable "infra-node-names" {
  type = list(string)
  default = ["node1", "node2"]
}

variable "infra-network-name" {
  type = string
  default = "labs"
  description = "Network Name"
}

variable "infra-network-type" {
  type = string
  default = "dhcp"
  description = "Nodes Network Type (static/dhcp)"
}

variable "infra-network-domain" {
  type = string
  default = "labs"
  description = "Nodes Network Domain"
}

variable "infra-network-nameserver" {
  type = string
  default = "8.8.8.8"
  description = "Nodes Network Nameserver"
}

variable "infra-network-subnet" {
  type = list(string)
  default = ["192.168.100.0/24"]
}

variable "infra-network-gateway" {
  type = string
  default = "192.168.100.1"
}

variable "infra-network-addresses" {
  type = list(string)
  default = ["192.168.100.11/24","192.168.100.12/24","192.168.100.13/24"]
}

variable "kvm_pool" {
  type = string
  default = "labs"
  description = "Pool for disk images and other resources (must be previously created)."

    # $ virsh pool-define-as --name labs --type dir --target /media/work/kvm
    # Pool default defined
    # Set pool to be started when libvirt daemons starts:

    # $ virsh pool-autostart labs
    # Pool default marked as autostarted
    # Start pool:

    # $ virsh pool-start labs
    # Pool default started

}

variable "kvm_bridge_interface" {
  type = string
  default = "br0"
  description = "Local Hypervior Bridge Interface."
}

variable "infra-node-vcpu" {
  type = string
  default = "2"
  description = "Node vCPU count"
}

variable "infra-node-memory" {
  type = string
  default = "3072"
  description = "Node Memory in MB"
}
