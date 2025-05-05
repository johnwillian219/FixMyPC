' input.vbs
Dim objShell, folderChoice
Set objShell = CreateObject("WScript.Shell")

folderChoice = InputBox("Escolha a pasta para bloquear/desbloquear (1-7):" & vbCrLf & _
    "1-Hacker" & vbCrLf & _
    "2-Documentos" & vbCrLf & _
    "3-Planos" & vbCrLf & _
    "4-Certificados" & vbCrLf & _
    "5-TEC" & vbCrLf & _
    "6-LEFT" & vbCrLf & _
    "7-MEFT" & vbCrLf & _
    "8-Futura Empresa", "Escolher Pasta")

WScript.Echo folderChoice
