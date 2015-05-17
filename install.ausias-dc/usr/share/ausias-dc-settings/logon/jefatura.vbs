'CONSTRUCTORS
'----------------------------------------------
Option Explicit

Dim objNetwork, objSysInfo, strUserDN
Dim objGroupList, objUser, objFSO
Dim strComputerDN, objComputer
Dim WshNetwork
Dim UserName
Dim ComputerName


set Wshnetwork = CreateObject("WScript.Network")
Set objNetwork = CreateObject("Wscript.Network")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objSysInfo = CreateObject("ADSystemInfo")

strUserDN = objSysInfo.userName
strComputerDN = objSysInfo.computerName

Set WshNetwork = WScript.CreateObject("WScript.Network")

' USERNAME & COMPUTER VARIABLES CONSTRUCTOR
' -----------------------------------------------------
' Save the username and computer name in variables
' ComputerName is converted to LOWERCASE to ensure proper matching later
' on.
UserName = WshNetwork.UserName
ComputerName = lcase(WshNetwork.ComputerName)

' pop a dialog box up on the client as you login that displays the computer name and users name
'WScript.Echo "You are logged into Computer = " & ComputerName & Chr(13) & " As Username = "& UserName

' Bind to the user and computer objects with the LDAP provider.
Set objUser = GetObject("LDAP://" & strUserDN)
Set objComputer = GetObject("LDAP://" & strComputerDN)



' NETWORK DRIVE ASSIGNMENTS
' -----------------------------------------------------------------
' Map a network drive if the user is a member of the group.
' Alert the user if the drive cannot be mapped.

WshNetwork.MapNetworkDrive "H:", "\\Servername\Users\"& UserName
WshNetwork.MapNetworkDrive "T:", "\\Servername\ClientApps"



If IsMember(objUser, "GroupName") Then

If Not MapDrive("P:", "\\Servername\Profiles") Then
MsgBox "Unable to Map P:\ to Profiles - Please contact ICT Services"
End If
End If

