Dim oNet, sUser, startTime, sUserDomain
Dim ObjGroupDict ' Dictionary of groups to which the user belongs
Set objFSO = CreateObject("Scripting.FileSystemObject")
On Error Resume Next



'===================== mensaje del Administrador ================================================================

' Objeto Red
Set oNet = CreateObject("WScript.Network")

' Obtenemos el login de usuario. En Windows 9x, el usuario puede no estar todav�a autentificado
' cuando el script comienza a ejecutarse; En ese caso reitera cada 1/2 segundo
sUser = oNet.UserName          'En min�sculas

startTime = Now
Do While sUser = ""
   If DateDiff("s", startTime, Now) > 600 Then Wscript.Quit
   Wscript.Sleep 500
   sUser = oNet.UserName
Loop
sUserDomain=oNet.UserDomain

' Read the user's account "Member Of" tab info across the network
' once into a dictionary object. 

Set ObjGroupDict = CreateMemberOfObject(sUserDomain, sUser)
If MemberOf(ObjGroupDict, "pr_jefatura") Then
	oNet.RemoveNetworkDrive "J:"
	oNet.MapNetworkDrive "J:", "\\jonas\jefatura"
End If


' Mapeado de la unidad F particular de cada usuario

oNet.RemoveNetworkDrive "S:"
oNet.MapNetworkDrive "S:", "\\jonas\" & sUser

oNet.RemoveNetworkDrive "T:"
oNet.MapNetworkDrive "T:", "\\jonas\Departamentos" 

oNet.RemoveNetworkDrive "U:"
oNet.MapNetworkDrive "U:", "\\jonas\Publico"

'oNet.RemoveNetworkDrive "Y:"
'oNet.MapNetworkDrive "Y:", "\\CCserver\ScanRepro"


' Abrimos el archivo con los login del grupo gescen y determinamos si el usuario actual pertenece al grupo
'Const ForReading = 1
'
'Set objTextFile = objFSO.OpenTextFile _
 '   ("\\FSserver\netlogon\gescen.txt", ForReading)
'Do Until objTextFile.AtEndOfStream
 '   strNextLine = objTextFile.Readline
  '  arrServiceList = Split(strNextLine , ",")
   ' For i = 0 to Ubound(arrServiceList)
    '    If arrServiceList(i) = sUser Then
'			bool = True
'			Exit For
'		Else
'			bool = False
'		End If	
 '   Next
'Loop
'
'
Set WshNetwork = CreateObject("WScript.Network")
'
'If bool = True Then	
'Es un profesor del equipo directivo	
'	oNet.RemoveNetworkDrive "X:"
'	oNet.MapNetworkDrive "X:", "\\FSserver\GC"
'	WshNetwork.AddWindowsPrinterConnection "\\CCServer\Fotocop_Secretaria"	
'End If	
'

'WshNetwork.AddWindowsPrinterConnection "\\CCServer\Fotocop_Profesores"
'WshNetwork.AddWindowsPrinterConnection "\\CCServer\Fotocop_Alumnos"

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.Run "\\fsserver\PCClient\win\pc-client-local-cache.exe -silent"

' MsgBox "Benvingut a ClickControl DS/Bienvenido a ClickControl DS" & Chr(13) & _
' "=================================" & Chr(13) & _
' ">>>> Visita la web:  www.dismacofax.com <<<<",vbInformation,"CLICK-CONTROL By DISMACO FAX"



'If objFSO.FileExists("S:\defaultprinter.txt") Then
'		Const ForReading2 = 1
'		Set objTextFile = objFSO.OpenTextFile _
'		("S:\defaultprinter.txt", ForReading2)
'		Do Until objTextFile.AtEndOfStream
'			strNextLine = objTextFile.Readline
'		Loop	
'		WshNetwork.SetDefaultPrinter strNextLine
'Else
'		WshNetwork.SetDefaultPrinter "\\CCServer\Fotocop_Profesores"
'End If	

' Establece la impresora por defecto
'WshNetwork.SetDefaultPrinter "ClickControl"	
	
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

