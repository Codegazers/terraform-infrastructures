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
   # - We can avoid using specific mac address removing "mac" key.
   # - Default net_type is dhcp
   #         "net_type" = "static",
   #         "nodeip_with_mask" = "192.168.202.10/24"
infra-nodes = [
      {
        "nodename"  = "master",
        "vcpu" = "2",
        "mem_in_gb" = "4",
        "sysdisk_in_gb" = 10,
        "datadisk_in_gb" = 10
        "net_type" = "static",
        "mac" = "52:54:00:b2:2f:80",
        "nodeip_with_mask" = "192.168.202.10/24"
     },
     {
        "nodename"  = "node1",
        "vcpu" = "2",
        "mem_in_gb" = "6",
        "sysdisk_in_gb" = 15,
        "datadisk_in_gb" = 30,
        "net_type" = "static",
        "mac" = "52:54:00:b2:2f:81",
        "nodeip_with_mask" = "192.168.202.11/24"
     },
     {
        "nodename"  = "node2",
        "vcpu" = "2",
        "mem_in_gb" = "6",
        "sysdisk_in_gb" = 15,
        "datadisk_in_gb" = 30,
        "net_type" = "static",
        "mac" = "52:54:00:b2:2f:82",
        "nodeip_with_mask" = "192.168.202.12/24"
     },
     {
        "nodename"  = "node3",
        "vcpu" = "2",
        "mem_in_gb" = "6",
        "sysdisk_in_gb" = 15,
        "datadisk_in_gb" = 30,
        "net_type" = "static",
        "mac" = "52:54:00:b2:2f:83",
        "nodeip_with_mask" = "192.168.202.13/24"
     },          
]
