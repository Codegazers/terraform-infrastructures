infra-lab = "labs"
infra-os-base-url = "https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64.img"
infra-node-names = ["node1", "node2", "node3"]
infra-network-name = "labs"
infra-network-domain = "labs"
infra-network-type = "static"
infra-network-nameserver = "8.8.8.8"
infra-network-gateway = "10.224.1.1"
infra-network-addresses = ["10.224.1.11/24","10.224.1.12/24","10.224.1.13/24"]
infra-network-subnet = ["10.224.1.0/24"]
private_key_path = "../keys/provision"
kvm_pool = "labs"
kvm_bridge_interface = "br0"
infra-node-vcpu = "2"
infra-node-memory = "3072"
infra-node-system_disk = 15 # GB
infra-node-data_disk = 25 # GB