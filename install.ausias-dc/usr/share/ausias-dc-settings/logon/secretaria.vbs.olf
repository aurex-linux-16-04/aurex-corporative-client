Dim oNet, sUser, startTime
On Error Resume Next
Set objFSO = CreateObject("Scripting.FileSystemObject")
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
oNet.MapNetworkDrive "S:", "\\Fsserver\" & sUser

oNet.RemoveNetworkDrive "T:"
oNet.MapNetworkDrive "T:", "\\Fsserver\Departamentos"


Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.Run "\\fsserver\PCClient\win\pc-client-local-cache.exe –silent"
 
Set WshNetwork = CreateObject("WScript.Network")
WshNetwork.SetDefaultPrinter "ClickControl"

		
MsgBox "Benvingut a ClickControl DS/Bienvenido a ClickControl DS" & Chr(13) & _
"=================================" & Chr(13) & _
">>>> Visita la web:  www.dismacofax.com <<<<",vbInformation,"CLICK-CONTROL By DISMACO FAX"		
