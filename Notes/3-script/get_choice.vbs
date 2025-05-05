' get_choice.vbs
Dim fso, ts, choiceFile
Set fso = CreateObject("Scripting.FileSystemObject")

choiceFile = "C:\Users\johnw\Desktop\Hacker\6-Ferramentas\6-Scripts\1-Script-para-bloquear-e-desbloquear-pastas-windows\3-script\choice.txt"
If fso.FileExists(choiceFile) Then
    Set ts = fso.OpenTextFile(choiceFile, 1)
    WScript.Echo ts.ReadLine
    ts.Close
    fso.DeleteFile choiceFile
Else
    WScript.Echo "Cancelar"
End If
