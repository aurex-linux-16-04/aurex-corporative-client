Dim oNet, sUser, startTime
Set objFSO = CreateObject("Scripting.FileSystemObject")
On Error Resume Next



'===================== mensaje del Administrador ================================================================

' Objeto Red
Set oNet = CreateObject("WScript.Network")

' Obtenemos el login de usuario. En Windows 9x, el usuario puede no estar todavía autentificado
' cuando el script comienza a ejecutarse; En ese caso reitera cada 1/2 segundo
sUser = oNet.UserName          'En minúsculas

startTime = Now
Do While sUser = ""
   If DateDiff("s", startTime, Now) > 600 Then Wscript.Quit
   Wscript.Sleep 500
   sUser = oNet.UserName
Loop


' Mapeado de la unidad F particular de cada usuario

oNet.RemoveNetworkDrive "S:"
oNet.MapNetworkDrive "S:", "\\satanas\" & sUser

oNet.RemoveNetworkDrive "T:"
oNet.MapNetworkDrive "T:", "\\satanas\Departamentos" 

oNet.RemoveNetworkDrive "U:"
oNet.MapNetworkDrive "U:", "\\satanas\Publico"

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
WshNetwork.SetDefaultPrinter "ClickControl"	
	

