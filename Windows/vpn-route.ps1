#
# Known bugs
# ----------
#
#   The interface name in the Event viewer message is not updated when the interface has been renamed
#
#
# Task scheduler configuration
# ----------------------------
#
#   Trigger on event
#     Log      : Microsoft-Windows-NetworkProfile/Operational
#     Source   : NetworkProfile
#     Event ID : 10000
#
#   Action
#     Program : powershell.exe
#     Syntax  : -WindowStyle Hidden -ExecutionPolicy Bypass "{AbsolutePathToScript}"
#     Example : -WindowStyle Hidden -ExecutionPolicy Bypass "C:\script\vpn-route.ps1"
#

function NewNetRoute{
	param([string[]]$dpList)
	$ip = (Get-NetIPAddress -InterfaceAlias $ia).IPAddress
	foreach ($dp in $dpList){
		New-NetRoute -PolicyStore ActiveStore -DestinationPrefix $dp -InterfaceAlias $ia -NextHop $ip
	}
}

$message = (Get-WinEvent -FilterHashTable @{LogName="Microsoft-Windows-NetworkProfile/Operational";Id=10000})[0].Message
$ia = [regex]::match($message,'^(?:[^:]+:) ([^\r\n]+)').Groups[1].Value

switch ($ia){
	# Syntax :
	#"[VPN connection name]" {	NewNetRoute {	[Destination network 1, Destination network 2, ...]	}	}
	# Examples :
	"VPN1" {	NewNetRoute "192.168.42.0/24"	}
	"VPN2" {	NewNetRoute "192.168.42.0/24","192.168.108.0/24","172.25.42.0/24	}
}
