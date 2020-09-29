#!/usr/bin/env python

import sys
import libvirt
import json
import socket

# We want to gather the hostname for Ansible.
hostname = socket.gethostbyaddr(socket.gethostname())[0]
# We want this to run on the local system only.
host_domain = 'qemu:///system'

virthost = libvirt.open(host_domain)
if virthost == None:
    sys.stderr.write('Failed to open connection to ' + host_domain, file=sys.stderr)
    exit(1)

# It took me a bit to figure out that there is no constant for all domains, just 0.  Hint was in libvirt-domain.h
alldomains = virthost.listAllDomains(0)
activedomains = virthost.listAllDomains(libvirt.VIR_CONNECT_LIST_DOMAINS_ACTIVE)
inactivedomains = virthost.listAllDomains(libvirt.VIR_CONNECT_LIST_DOMAINS_INACTIVE)

for domain in activedomains:
    #print (domain.name()+ ":")
    dom = virthost.lookupByName(domain.name())
    ifaces = dom.interfaceAddresses(libvirt.VIR_DOMAIN_INTERFACE_ADDRESSES_SRC_AGENT, 0)
    #print (ifaces)
    for (name, val) in ifaces.items():
        if name == "lo":
            continue
        if val['addrs']:
            for ipaddr in val['addrs']:
                if ipaddr['type'] == libvirt.VIR_IP_ADDR_TYPE_IPV4:
                    print(domain.name()+ " - "+ name + " - " + ipaddr['addr'])


virthost.close()
exit()
