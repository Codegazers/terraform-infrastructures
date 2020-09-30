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

activedomains = virthost.listAllDomains(libvirt.VIR_CONNECT_LIST_DOMAINS_ACTIVE)
inventory = {}

for domain in activedomains:
    dom = virthost.lookupByName(domain.name())
    state, reason = dom.state()
    if state == libvirt.VIR_DOMAIN_NOSTATE:
        vmstate="nostate"
    elif state == libvirt.VIR_DOMAIN_RUNNING:
        vmstate="running"
    elif state == libvirt.VIR_DOMAIN_BLOCKED:
        vmstate="blocked"
    elif state == libvirt.VIR_DOMAIN_PAUSED:
        vmstate="paused"
    elif state == libvirt.VIR_DOMAIN_SHUTDOWN:
        vmstate="shutdown"
    elif state == libvirt.VIR_DOMAIN_SHUTOFF:
        vmstate="shutoff"
    elif state == libvirt.VIR_DOMAIN_CRASHED:
        vmstate="crashed"
    elif state == libvirt.VIR_DOMAIN_PMSUSPENDED:
        vmstate="suspended"
    else:
        vmstate="unknown"

    inventory[domain.name()]={}
    state, maxmem, mem, cpus, cput = dom.info()
    try:
        inventory[domain.name()]['hostname']=domain.hostname()
    except:
        exit(1)
    inventory[domain.name()]['vmstate']=vmstate
    inventory[domain.name()]['mem']=str(maxmem/1024/1024)+"GB/"+str(mem/1024/1024)+"GB"
    inventory[domain.name()]['cpu']=cpus
    #print ("vm: %s hostname: %s state: %s mem: %dGB/%dGB cpu: %dvCPU" % (domain.name(),domain.hostname(),vmstate, maxmem/1024/1024, mem/1024/1024, cpus))
    ifaces = dom.interfaceAddresses(libvirt.VIR_DOMAIN_INTERFACE_ADDRESSES_SRC_AGENT, 0)
    #print (ifaces)
    for (name, val) in ifaces.items():
        if name == "lo":
            continue
        if val['addrs']:
            for ipaddr in val['addrs']:
                if ipaddr['type'] == libvirt.VIR_IP_ADDR_TYPE_IPV4:
                    inventory[domain.name()]['interface']=name
                    inventory[domain.name()]['ipaddress']=ipaddr['addr']

if len(sys.argv) == 2 and sys.argv[1] == '--json':
    print(json.dumps(inventory, indent=4, sort_keys=True))
elif len(sys.argv) == 2 and sys.argv[1] == '--ansible':
    for node in sorted(inventory.keys()):
        print(str(node)+ " ansible_ssh_host="+inventory[node]['ipaddress']+" node_hostname="+ str(node))
elif len(sys.argv) == 2 and sys.argv[1] == '--hosts':
    for node in sorted(inventory.keys()):
        print(str(node)+ " - "+ inventory[node]['interface'] + " - " + inventory[node]['ipaddress'])
else:
    for node in sorted(inventory.keys()):
        print(str(node))
        for key in sorted(inventory[node].keys()):
            print("\t"+key+": "+str(inventory[node][key]))
virthost.close()
exit()
