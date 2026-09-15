@echo off
setlocal EnableExtensions
chcp 65001 >nul
cd /d "%~dp0"
set "SHORTCUT=%USERPROFILE%\Desktop\Food Planner.lnk"
set "URL=https://mphimu.github.io/food-planner-app/"

echo ==========================================
echo          FOOD PLANNER - УСТАНОВКА
 echo ==========================================
echo.

echo Создаю ярлык на рабочем столе...

powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $url='%URL%'; $desktop=[Environment]::GetFolderPath('Desktop'); $lnk=Join-Path $desktop 'Food Planner.lnk'; $edge=@($env:ProgramFiles+'\Microsoft\Edge\Application\msedge.exe',${env:ProgramFiles(x86)}+'\Microsoft\Edge\Application\msedge.exe',$env:LOCALAPPDATA+'\Microsoft\Edge\Application\msedge.exe') | Where-Object {$_ -and (Test-Path $_)} | Select-Object -First 1; $chrome=@($env:ProgramFiles+'\Google\Chrome\Application\chrome.exe',${env:ProgramFiles(x86)}+'\Google\Chrome\Application\chrome.exe',$env:LOCALAPPDATA+'\Google\Chrome\Application\chrome.exe') | Where-Object {$_ -and (Test-Path $_)} | Select-Object -First 1; if($edge){$target=$edge;$args='--app="'+$url+'" --start-maximized'} elseif($chrome){$target=$chrome;$args='--app="'+$url+'" --start-maximized'} else {throw 'Не найден Microsoft Edge или Google Chrome.'}; $ws=New-Object -ComObject WScript.Shell; $s=$ws.CreateShortcut($lnk); $s.TargetPath=$target; $s.Arguments=$args; $s.WorkingDirectory=(Split-Path $target); $s.IconLocation='%~dp0icon.ico'; $s.Description='Food Planner'; $s.Save(); if(!(Test-Path $lnk)){throw 'Ярлык не был создан.'}; Start-Process $target -ArgumentList $args"
if errorlevel 1 (
  echo.
  echo ОШИБКА: установка не завершена.
  echo Проверь, что Microsoft Edge или Google Chrome установлен.
  pause
  exit /b 1
)

echo.
echo ГОТОВО! Ярлык Food Planner создан на рабочем столе.
echo Запускаю приложение...
start "" "%SHORTCUT%"
timeout /t 2 /nobreak >nul
exit /b 0
