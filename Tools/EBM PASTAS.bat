@echo off
setlocal enabledelayedexpansion

:: Caminho do executável (mesma pasta do .bat)
set "EXE=%~dp0gust_ebm.exe"

if not exist "%EXE%" (
    echo ERRO: gust_ebm.exe nao encontrado na pasta do script.
    pause
    exit /b
)

if "%~1"=="" (
    echo Arraste uma ou mais pastas sobre este .bat.
    echo Todos os arquivos serao processados pelo gust_ebm.exe e os originais DELETADOS.
    pause
    exit /b
)

echo.
echo =============================================
echo   Processando e deletando originais...
echo =============================================
echo.

:loop
if "%~1"=="" goto fim
set "pasta=%~1"

if not exist "%pasta%\" (
    echo [AVISO] "%pasta%" nao e uma pasta. Pulando...
    shift
    goto loop
)

echo Processando pasta: "%pasta%"
for /f "delims=" %%A in ('dir /a-d /b "%pasta%" 2^>nul') do (
    set "arquivo=%pasta%\%%A"
    echo   - %%A
    "%EXE%" "!arquivo!"
    if errorlevel 1 (
        echo     [ERRO] falha no processamento - arquivo NAO foi deletado.
    ) else (
        del "!arquivo!"
        echo     OK - original deletado.
    )
)
shift
goto loop

:fim
echo.
echo Concluido. Todos os originais processados e removidos.
pause