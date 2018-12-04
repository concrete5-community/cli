@echo off
setlocal enabledelayedexpansion

call :GET_C5_BIN
if errorlevel 1 (
    echo Unable to find the concrete5 root directory >&2
    exit /b 1
)
setlocal disabledelayedexpansion
php -d short_open_tag=On "%C5_BIN%" %*
exit /b 0

:GET_C5_BIN
call :GET_C5_ROOT
if errorlevel 1 exit /b 1
if exist "%C5_ROOT%\concrete\bin\concrete5.php" (
  set C5_BIN=%C5_ROOT%\concrete\bin\concrete5.php
) else (
  set C5_BIN=%C5_ROOT%\concrete\bin\concrete5
)
exit /b 0


:GET_C5_ROOT
call :GET_ABS_PATH .
call :CHECK_C5_ROOT
if not errorlevel 1 exit /b 0

call :GET_ABS_PATH public
call :CHECK_C5_ROOT
if not errorlevel 1 exit /b 0

call :GET_ABS_PATH web
call :CHECK_C5_ROOT
if not errorlevel 1 exit /b 0

set PARENT_PATH=..
set PREVIOUS_C5_ROOT=
for /L %%i in (1, 1, 100) do (
    call :GET_ABS_PATH "!PARENT_PATH!"
    if "!C5_ROOT!" == "!PREVIOUS_C5_ROOT!" exit /b 1
    call :CHECK_C5_ROOT
    if errorlevel 2 exit /b 1
    if not errorlevel 1 exit /b 0
    set PARENT_PATH=!PARENT_PATH!\..
    set PREVIOUS_C5_ROOT=!C5_ROOT!
)
exit /b 1

:GET_ABS_PATH
set C5_ROOT=
pushd "%~1" 2>NUL
if errorlevel 1 exit /b 0
set C5_ROOT=%CD%
popd
exit /b 0

:CHECK_C5_ROOT
if "%C5_ROOT%" == "" exit /b 2
if exist "%C5_ROOT%\concrete\dispatcher.php" exit /b 0
exit /b 1
