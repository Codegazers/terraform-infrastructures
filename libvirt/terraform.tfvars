infra-lab = "labs"
#infra-os-base-url = "/virtual/base_images/labs/bionic64-base-image.img"
#infra-os-base-url = "https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.3.2011-20201204.2.x86_64.qcow2"
infra-os-base-url = "/virtual/base_images/rhel-8.3-x86_64-kvm.qcow2"

# Common Network Configuration
infra-network-name = "labs"
infra-network-domain = "labs.local"
infra-network-nameserver = "8.8.8.8"
#infra-network-subnet = ["192.168.202.0/23"] # Only for non-ip-static environments and should not exist in your host.
infra-network-bridge = true #


private_key_path = "../keys/provision"
kvm_pool = "labs"
kvm_bridge_interface = "bridge0"


# Configuration for each node
   # - We can avoid using specific mac address removing "mac" key.
   # - Default net_type is dhcp
   #         "net_type" = "static",
   #         "nodeip_with_mask" = "192.168.202.10/24"
infra-nodes = [
      {
        "nodename"  = "one",
        "vcpu" = "1",
        "mem_in_gb" = "3",
        "sysdisk_in_gb" = 10,
        "datadisk_in_gb" = 10,
        "net_type" = "static",
        "mac" = "52:54:00:b2:2f:80",
        "nodeip_with_mask" = "192.168.201.131/23",
        "nodeip_gateway" = "192.168.200.1"
      },
      {
        "nodename"  = "two",
        "vcpu" = "1",
        "mem_in_gb" = "3",
        "sysdisk_in_gb" = 10,
        "datadisk_in_gb" = 10,
        "net_type" = "static",
        "mac" = "52:54:00:b2:2f:81",
        "nodeip_with_mask" = "192.168.201.132/23",
        "nodeip_gateway" = "192.168.200.1"
     },
           {
        "nodename"  = "three",
        "vcpu" = "1",
        "mem_in_gb" = "3",
        "sysdisk_in_gb" = 10,
        "datadisk_in_gb" = 10,
        "net_type" = "static",
        "mac" = "52:54:00:b2:2f:82",
        "nodeip_with_mask" = "192.168.201.133/23",
        "nodeip_gateway" = "192.168.200.1"
      },
      {
        "nodename"  = "four",
        "vcpu" = "1",
        "mem_in_gb" = "3",
        "sysdisk_in_gb" = 10,
        "datadisk_in_gb" = 10,
        "net_type" = "static",
        "mac" = "52:54:00:b2:2f:83",
        "nodeip_with_mask" = "192.168.201.134/23",
        "nodeip_gateway" = "192.168.200.1"
     },
      {
        "nodename"  = "five",
        "vcpu" = "1",
        "mem_in_gb" = "3",
        "sysdisk_in_gb" = 10,
        "datadisk_in_gb" = 10,
        "net_type" = "static",
        "mac" = "52:54:00:b2:2f:83",
        "nodeip_with_mask" = "192.168.201.135/23",
        "nodeip_gateway" = "192.168.200.1"
     },
]

