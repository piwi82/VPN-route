# VPN route

The default settings on a VPN client sends all traffic over the VPN connection, which "disables" your Internet connection. 

![Windows VPN default gateway](https://github.com/piwi82/VPN-route/blob/master/Windows/vpn-default-gateway-windows.png)

It is possible to automatically create the required routing rules each time a VPN connection is established, and thus preserve your local internet access.

Mac, Linux and Unix like OSes uses a very simple script stored in `/etc/ppp/ip-up`.
Windows can do something similar using a [PowerShell script and the Task Scheduler](https://github.com/piwi82/VPN-route/blob/master/Windows/vpn-route.ps1).

This readme will be updated with a complete guide, and special tips for Synology NASes.
