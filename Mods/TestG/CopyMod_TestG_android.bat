set ANDROIDHOME=D:/Apps/contractors-modkit/ModKit_0.93.0/ModProject/Resources
set ADB=%ANDROIDHOME%/platform-tools/adb.exe

setlocal EnableDelayedExpansion  

set batname= %~n0

set pakfilename=%batname:CopyMod_=%
set "pakfilename=%pakfilename: =%"

for /f "delims=" %%y in ('dir /a:d /b') do (
echo %%y| findstr %pakfilename% >nul && (
    echo %%y contains %pakfilename%
    set pakfilename="%%y"
)
)
:filefinded
@echo pak file name :!pakfilename!

set DEVICE=
if not "%1"=="" set DEVICE=-s %1
for /f "delims=" %%A in ('%ADB% %DEVICE% shell "echo $EXTERNAL_STORAGE"') do @set STORAGE=%%A 

set "STORAGE=%STORAGE: =%"


call :print !pakfilename!
@echo %file_name%
set newpakname=%file_name%
%ADB% %DEVICE% shell mkdir  %STORAGE%/Android/data/com.CaveManStudio.ContractorsVR/files/ModsTest
%ADB% %DEVICE% push !pakfilename! %STORAGE%/Android/data/com.CaveManStudio.ContractorsVR/files/ModsTest/%newpakname%

:print
set file_path=%~dp1

set file_name=%~n1

set suffix=%~x1



