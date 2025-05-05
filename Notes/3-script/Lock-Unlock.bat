@echo off
setlocal enabledelayedexpansion

rem Caminho para os scripts HTA e VBScript
set "scriptPath=C:\Users\johnw\Desktop\Hacker\6-Ferramentas\6-Scripts\1-Script-para-bloquear-e-desbloquear-pastas-windows\3-script"

rem Definir o caminho para o arquivo temporário de carregamento
set "loadingFile=%temp%\loading.txt"

:MAIN
rem Pergunta se deseja bloquear ou desbloquear usando HTA
set "choice="
mshta "%scriptPath%\dialog.hta"
for /f "delims=" %%i in ('cscript //nologo "%scriptPath%\get_choice.vbs"') do set "choice=%%i"

if "%choice%"=="Bloquear" goto CHOOSELOCK
if "%choice%"=="Desbloquear" goto CHOOSEUNLOCK
if "%choice%"=="Cancelar" exit /b

echo Escolha invalida.
goto MAIN

:CHOOSELOCK
rem Solicita a pasta para bloquear
for /f "delims=" %%i in ('cscript //nologo "%scriptPath%\input.vbs"') do set "foldernum=%%i"
if "%foldernum%"=="1" set "foldername=Hacker" & set "uniqueid=0001" & goto LOCK
if "%foldernum%"=="2" set "foldername=Documentos" & set "uniqueid=0002" & goto LOCK
if "%foldernum%"=="3" set "foldername=Planos" & set "uniqueid=0003" & goto LOCK
if "%foldernum%"=="4" set "foldername=Certificados" & set "uniqueid=0004" & goto LOCK
if "%foldernum%"=="5" set "foldername=TEC" & set "uniqueid=0005" & goto LOCK
if "%foldernum%"=="6" set "foldername=LEFT" & set "uniqueid=0006" & goto LOCK
if "%foldernum%"=="7" set "foldername=MEFT" & set "uniqueid=0007" & goto LOCK
if "%foldernum%"=="8" set "foldername=Futura Empresa" & set "uniqueid=0008" & goto LOCK
echo Escolha invalida.
goto CHOOSELOCK

:CHOOSEUNLOCK
rem Solicita a pasta para desbloquear
for /f "delims=" %%i in ('cscript //nologo "%scriptPath%\input.vbs"') do set "foldernum=%%i"
if "%foldernum%"=="1" set "foldername=Hacker" & set "uniqueid=0001" & goto UNLOCK
if "%foldernum%"=="2" set "foldername=Documentos" & set "uniqueid=0002" & goto UNLOCK
if "%foldernum%"=="3" set "foldername=Planos" & set "uniqueid=0003" & goto UNLOCK
if "%foldernum%"=="4" set "foldername=Certificados" & set "uniqueid=0004" & goto UNLOCK
if "%foldernum%"=="5" set "foldername=TEC" & set "uniqueid=0005" & goto UNLOCK
if "%foldernum%"=="6" set "foldername=LEFT" & set "uniqueid=0006" & goto UNLOCK
if "%foldernum%"=="7" set "foldername=MEFT" & set "uniqueid=0007" & goto UNLOCK
if "%foldernum%"=="8" set "foldername=Futura Empresa" & set "uniqueid=0008" & goto UNLOCK
echo Escolha invalida.
goto CHOOSEUNLOCK

:LOCK
rem Iniciar o tempo
set "startTime=%time%"

rem Exibir mensagem de carregamento
echo Aplicando atributos, por favor, aguarde...
echo.

rem Criar um arquivo temporário de carregamento
echo Carregando... > "%loadingFile%"

rem Verifica se a pasta já está bloqueada
if EXIST "%foldername%{%uniqueid%}" (
    echo A pasta ja esta bloqueada.
    del "%loadingFile%"
    goto MAIN
)

rem Cria a pasta se não existir
if NOT EXIST "%foldername%" (
    md "%foldername%"
)

rem Renomeia a pasta para adicionar o identificador único
ren "%foldername%" "%foldername%{%uniqueid%}"

rem Define atributos oculto e sistema
attrib +h +s "%foldername%{%uniqueid%}"

rem Remove o arquivo temporário de carregamento
del "%loadingFile%"

rem Calcular o tempo decorrido
set "endTime=%time%"

echo.
echo Pasta bloqueada com sucesso.
echo Tempo de início: %startTime%
echo Tempo de término: %endTime%
goto MAIN

:UNLOCK
rem Iniciar o tempo
set "startTime=%time%"

rem Exibir mensagem de carregamento
echo Aplicando atributos, por favor, aguarde...
echo.

rem Criar um arquivo temporário de carregamento
echo Carregando... > "%loadingFile%"

rem Verifica se a pasta não está bloqueada
if NOT EXIST "%foldername%{%uniqueid%}" (
    echo A pasta ja esta desbloqueada ou nao existe.
    del "%loadingFile%"
    goto MAIN
)

rem Solicita a senha
for /f "delims=" %%i in ('cscript //nologo "%scriptPath%\password.vbs"') do set "pass=%%i"
if NOT "%pass%"=="8520" goto FAIL

rem Remove atributos oculto e sistema
attrib -h -s "%foldername%{%uniqueid%}"

rem Renomeia a pasta de volta ao nome original
ren "%foldername%{%uniqueid%}" "%foldername%"

rem Remove o arquivo temporário de carregamento
del "%loadingFile%"

rem Calcular o tempo decorrido
set "endTime=%time%"

echo.
echo Pasta desbloqueada com sucesso.
echo Tempo de início: %startTime%
echo Tempo de término: %endTime%
goto MAIN

:FAIL
echo Senha incorreta.
goto MAIN
