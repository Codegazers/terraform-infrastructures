infra-lab = "labs"
infra-os-base-url = "https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64.img"


# Node Names and Hardware Resources
infra-node-names = ["node1", "node2"]
infra-node-vcpu = "2"
infra-node-memory = "3072"
infra-node-system_disk = 15 # GB
infra-node-data_disk = 25 # GB

# Network Configuration and Node IP Addresses (Static/DHCP)
infra-network-name = "labs"
infra-network-domain = "labs"
infra-network-type = "dhcp"
infra-network-nameserver = "8.8.8.8"
infra-network-gateway = "192.168.200.1"
infra-network-addresses = ["192.168.200.211/24","192.168.200.212/24"]
infra-network-subnet = ["10.224.1.0/24"]
infra-network-bridge = false #


private_key_path = "../keys/provision"
kvm_pool = "labs"
kvm_bridge_interface = "br0"

