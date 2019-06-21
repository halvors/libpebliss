set DEST = %1
if "%DEST%" == "" set DEST=.\pub
set DEST=%DEST%\libpebliss

if exist "%DEST%" rd /s /q "%DEST%"
mkdir "%DEST%\include"

xcopy pe_lib\*.h "%DEST%\include"
xcopy /e lib "%DEST%\lib\"