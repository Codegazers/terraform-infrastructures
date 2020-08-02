infra-lab = "labs"
infra-os-base-url = "/virtual/kvm_pools/labs/bionic64-base-image.img"


# Common Network Configuration
infra-network-name = "labs"
infra-network-domain = "labs"
infra-network-nameserver = "8.8.8.8"
infra-network-gateway = "192.168.202.1"
infra-network-subnet = ["192.168.202.0/24"]
infra-network-bridge = false #


private_key_path = "../keys/provision"
kvm_pool = "labs"
kvm_bridge_interface = "br0"


# Configuration for each node

infra-nodes = [
      {
        "nodename"  = "test1",
        "vcpu" = "2",
        "mem_in_gb" = "4",
        "sysdisk_in_gb" = 15,
        "datadisk_in_gb" = 20,
        "net_type" = "static",
        "nodeip_with_mask" = "192.168.202.211/24"
     },
    ]
