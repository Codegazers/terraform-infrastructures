infra-lab = "labs"
infra-os-base-url = "https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64.img"


# Node Names and Hardware Resources

infra-node-system_disk = 20 # GB
infra-node-data_disk = 15 # GB

# Network Configuration and Node IP Addresses (Static/DHCP)
infra-network-name = "labs"
infra-network-domain = "labs"
infra-network-type = "static"
infra-network-nameserver = "8.8.8.8"
infra-network-gateway = "192.168.202.1"
infra-network-subnet = ["192.168.202.0/24"]
infra-network-bridge = false #


private_key_path = "../keys/provision"
kvm_pool = "labs"
kvm_bridge_interface = "br0"

