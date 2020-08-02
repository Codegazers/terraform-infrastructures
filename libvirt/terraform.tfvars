infra-lab = "labs"
infra-os-base-url = "https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64.img"


# Node Names and Hardware Resources
infra-node-names = ["node1", "node2","node3","node4"]
infra-node-vcpu = "4"
infra-node-memory = "8072"
infra-node-system_disk = 20 # GB
infra-node-data_disk = 15 # GB

# Network Configuration and Node IP Addresses (Static/DHCP)
infra-network-name = "labs"
infra-network-domain = "labs"
infra-network-type = "static"
infra-network-nameserver = "8.8.8.8"
infra-network-gateway = "192.168.202.1"
infra-network-addresses = ["192.168.202.211/24","192.168.202.212/24","192.168.202.213/24","192.168.202.214/24"]
infra-network-subnet = ["192.168.202.0/24"]
infra-network-bridge = false #


private_key_path = "../keys/provision"
kvm_pool = "labs"
kvm_bridge_interface = "br0"

