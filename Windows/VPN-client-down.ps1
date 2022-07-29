# Task scheduler configuration
# ----------------------------
#
#   Trigger on event
#     Log      : Microsoft-Windows-NetworkProfile/Operational
#     Source   : NetworkProfile
#     Event ID : 10001
#
#   Action
#     Program : powershell.exe
#     Syntax  : -WindowStyle Hidden -ExecutionPolicy Bypass "{AbsolutePathToScript}"
#     Example : -WindowStyle Hidden -ExecutionPolicy Bypass "C:\script\vpn-client-down.ps1"

$message = (Get-WinEvent -FilterHashTable @{LogName="Microsoft-Windows-NetworkProfile/Operational";Id=10001})[0].Message
$interfaceAlias = [regex]::match($message,'Desc : ([^\r\n]+)').Groups[1].Value

switch ($interfaceAlias){
	# Syntax :
	#"[VPN connection description]" {	Remove-DnsClientNrptRule -Name (Get-DnsClientNrptRule | Where-Object {$_.NameServers -eq "DNS Server IP address"}).Name -Force	}	}
	"Gordon" {	Remove-DnsClientNrptRule -Name (Get-DnsClientNrptRule | Where-Object {$_.NameServers -eq "192.168.253.251"}).Name -Force	}
}
