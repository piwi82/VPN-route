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
#     Example : -WindowStyle Hidden -ExecutionPolicy Bypass "C:\script\vpn-client-up.ps1"

function NewNetRoute{
	param([string[]]$destinationPrefixList)
	$nextHop = (Get-NetIPAddress -InterfaceAlias $interfaceAlias).IPAddress
	foreach ($destinationPrefix in $destinationPrefixList){
		New-NetRoute `
			-PolicyStore ActiveStore `
			-DestinationPrefix $destinationPrefix `
			-InterfaceAlias $interfaceAlias `
			-NextHop $nextHop
	}
}

$message = (Get-WinEvent -FilterHashTable @{LogName="Microsoft-Windows-NetworkProfile/Operational";Id=10000})[0].Message
$interfaceAlias = [regex]::match($message,'Desc : ([^\r\n]+)').Groups[1].Value

switch ($interfaceAlias){
	# Syntax :
	#"[VPN connection description]" {
	#	# Added routes to remote network
	#	NewNetRoute {	["[Destination network 1]", "[Destination network 2]", ...]	}
	#	# Added rule to resolve domain to remote network addresses
	#	Add-DnsClientNrptRule -Namespace "[Remote domain]" -NameServers "[Remote DNS server IP address]"
	#}
	"VPN" {
		NewNetRoute "192.168.0.0/24" "10.0.0.0/16"
		Add-DnsClientNrptRule -Namespace ".domain.tld" -NameServers "192.168.0.1"
	}
}
