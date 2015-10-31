# VPN route

The default settings on a VPN client sends all traffic over the VPN connection, which "disables" your Internet connection. 

It is possible to automatically create the required routing rules each time a VPN connection is established, and thus preserve your local internet access.

Mac, Linux and Unix like OSes uses a very simple script stored in `/etc/ppp/ip-up`.
Windows can do something similar using a PowerShell script with the Task Scheduler.