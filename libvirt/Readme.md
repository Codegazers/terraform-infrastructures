```
$ virsh --connect=qemu:///system domifaddr  --domain master --source agent | awk '!/^ -|^ lo|-| Name/ {print $4}'
```




>NOTE: Recover Static IP addresses:
>```
>$ virsh domifaddr  --domain node1 --source agent
> Name       MAC address          Protocol     Address
>-------------------------------------------------------------------------------
> lo         00:00:00:00:00:00    ipv4         127.0.0.1/8
> -          -                    ipv6         ::1/128
> ens3       52:54:00:be:96:da    ipv4         10.224.1.11/24
> -          -                    ipv6         fe80::5054:ff:febe:96da/64
>```


```
alias tssh='ssh -o "StrictHostKeyChecking=no" -i ~/.ssh/provision -l provision'

```


Error: Error in function call

  on main.tf line 26, in data "template_file" "network_config":
  26:   template = file("${path.module}/cloudinit_net_${lookup(var.infra-nodes[count.index], "net_type")}.cfg")
    |----------------
    | count.index is 2
    | var.infra-nodes is list of map of string with 4 elements

Call to function "lookup" failed: lookup failed to find 'net_type'.


Error: Error in function call

  on main.tf line 26, in data "template_file" "network_config":
  26:   template = file("${path.module}/cloudinit_net_${lookup(var.infra-nodes[count.index], "net_type")}.cfg")
    |----------------
    | count.index is 1
    | var.infra-nodes is list of map of string with 4 elements

Call to function "lookup" failed: lookup failed to find 'net_type'.


Error: Error in function call

  on main.tf line 26, in data "template_file" "network_config":
  26:   template = file("${path.module}/cloudinit_net_${lookup(var.infra-nodes[count.index], "net_type")}.cfg")
    |----------------
    | count.index is 3
    | var.infra-nodes is list of map of string with 4 elements

Call to function "lookup" failed: lookup failed to find 'net_type'.
