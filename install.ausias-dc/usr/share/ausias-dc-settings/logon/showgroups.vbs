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

Set objUser = GetObject("WinNT://" _
& strUserDomain & "/" _
& strUserName & ",user")
For Each objGroup In objUser.Groups
wscript.echo objGroup.Name
Next

