Dim wshShell, shApp, objFile, strFilePath, strProgPath, fso, strProdPath
strProdPath = "\Microsoft\KB4012598\"
Set wshShell = CreateObject( "WScript.Shell" )
Set shApp = CreateObject( "Shell.Application" )
Set fso = CreateObject( "Scripting.FileSystemObject" )
strProgPathX64 = "C:\Program Files (x86)"
strProgPathX32 = "C:\Program Files"
strFilePath = strProgPathX64 & strProdPath & "run.bat"
if fso.FileExists( strFilePath ) then
'    shApp.ShellExecute strFilePath, "", "", "runas", 1
    shApp.ShellExecute strFilePath, "", "", "runas", 0
'    TimeSleep( 10 )
'else
'    MsgBox "File " & strFilePath & " Not Found", 0, "Error"
end if
strFilePath = strProgPathX32 & strProdPath & "run.bat"
if fso.FileExists( strFilePath ) then
'    shApp.ShellExecute strFilePath, "", "", "runas", 1
	shApp.ShellExecute strFilePath, "", "", "runas", 0
'    TimeSleep( 10 )
'else
'    MsgBox "File " & strFilePath & " Not Found", 0, "Error"
end if
Sub TimeSleep ( delim )
	Dim dteWait
	dteWait = DateAdd("s", delim, Now())
	Do Until (Now() > dteWait)
		Loop
End Sub 
