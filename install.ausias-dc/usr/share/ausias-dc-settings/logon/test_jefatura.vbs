Option Explicit ' Force explicit declarations
'
' Variables
'
Dim WSHNetwork
Dim FSO
Dim strUserName ' Current user
Dim strUserDomain ' Current User's domain name
Dim ObjGroupDict ' Dictionary of groups to which the user belongs

Set WSHNetwork = WScript.CreateObject("WScript.Network")
Set FSO = CreateObject("Scripting.FileSystemObject")
'
' Wait until the user is really logged in...
'
strUserName = ""
While strUserName = ""
WScript.Sleep 100 ' 1/10 th of a second
strUserName = WSHNetwork.UserName
Wend
strUserDomain = WSHNetwork.UserDomain

' Read the user's account "Member Of" tab info across the network
' once into a dictionary object. 

Set ObjGroupDict = CreateMemberOfObject(strUserDomain, strUserName)
If MemberOf(ObjGroupDict, "pr_jefatura") Then
wscript.echo "Is a member of pr_jefatura." 
'REM this line to Map Network Drives

'Map network Drives here, UNREM the below lines:
'WSHNetwork.MapNetworkDrive "O:", "\\server1\share"
WSHNetwork.MapNetworkDrive "J:", "\\satanas\jefatura"

Else
wscript.echo "Is NOT a member pr_jefaturaa"
End If

Function MemberOf(ObjDict, strKey)
' Given a Dictionary object containing groups to which the user
' is a member of and a group name, then returns True if the group
' is in the Dictionary else return False. 
'
' Inputs:
' strDict - Input, Name of a Dictionary object
' strKey - Input, Value being searched for in
' the Dictionary object
' Sample Usage:
'
' If MemberOf(ObjGroupDict, "DOMAIN ADMINS") Then
' wscript.echo "Is a member of Domain Admins."
' End If
'
'
MemberOf = CBool(ObjGroupDict.Exists(strKey))

End Function


Function CreateMemberOfObject(strDomain, strUserName)
' Given a domain name and username, returns a Dictionary
' object of groups to which the user is a member of.
'
' Inputs:
'
' strDomain - Input, NT Domain name
' strUserName - Input, NT username
'
Dim objUser, objGroup

Set CreateMemberOfObject = CreateObject("Scripting.Dictionary")
CreateMemberOfObject.CompareMode = vbTextCompare
Set objUser = GetObject("WinNT://" _
& strDomain & "/" _
& strUserName & ",user")
For Each objGroup In objUser.Groups
CreateMemberOfObject.Add objGroup.Name, "-"
Next
Set objUser = Nothing

End Function

