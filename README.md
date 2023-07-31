# ☠️ VPN route

The contents of this repository is **obsolete** as PowerShell commands can now do the same.

Take a look at the [Add-VpnConnectionRoute](https://learn.microsoft.com/en-us/powershell/module/vpnclient/add-vpnconnectionroute) PowerShell command to add routes to VPN connections, and use `(Get-VpnConnection).Routes` to view configured routes.

---

The default settings on a VPN client sends all traffic over the VPN connection, which "disables" your Internet access.

![Windows VPN default gateway](https://github.com/piwi82/VPN-route/blob/master/Windows/vpn-default-gateway-windows.png)

It is possible to automatically create the required routing rules each time a VPN connection is established, and thus preserve your local Internet access.

Mac, Linux and Unix like OSes use a very simple script stored in `/etc/ppp/ip-up`.
Windows can do something similar using a [PowerShell script and the Task Scheduler](https://github.com/piwi82/VPN-route/blob/master/Windows/vpn-route.ps1).
