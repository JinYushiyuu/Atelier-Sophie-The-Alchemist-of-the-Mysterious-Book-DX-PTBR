@echo off
setlocal enabledelayedexpansion

:: Executável conversor na mesma pasta do .bat
set "CONVERSOR=%~dp0gust_g1t.exe"

:: Verifica se o conversor existe
if not exist "%CONVERSOR%" (
    echo ERRO: Conversor nao encontrado em "%CONVERSOR%"
    echo Certifique-se de que o gust_ebm.exe esta na mesma pasta que este .bat.
    pause
    exit /b 1
)

:: Processa cada arquivo arrastado
for %%f in (%*) do (
    echo Convertendo: "%%~f"
    "%CONVERSOR%" "%%~f"
    if errorlevel 1 (
        echo Falha ao converter "%%~f"
    ) else (
        echo Concluido: "%%~f"
    )
)

echo.
echo Processo finalizado.