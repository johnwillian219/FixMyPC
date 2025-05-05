' password.vbs
Dim objShell, password
Set objShell = CreateObject("WScript.Shell")

password = InputBox("Digite a senha para desbloquear:", "Senha")

WScript.Echo password
