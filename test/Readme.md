
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
