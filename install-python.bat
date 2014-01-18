@echo off

set PYTHON_VERSION=2.7.6
set PYTHON_MSI=python-%PYTHON_VERSION%.msi
set PYTHON_EXE=c:\\Python2.7\\python.exe
set PYTHON_PATH="C:\Python27;c:\Python27\Scripts"

echo,
echo ------------------------------------------------------------------
echo Download Python
echo ------------------------------------------------------------------
echo,

if not exist %PYTHON_EXE% (
if not exist %PYTHON_MSI% (
  curl -L -O http://python.org/ftp/python/%PYTHON_VERSION%/%PYTHON_MSI%
)
)

echo,
echo ------------------------------------------------------------------
echo Install Python
echo ------------------------------------------------------------------
echo,

if not exist %PYTHON_EXE% (
if exist %PYTHON_MSI% (
    msiexec.exe /i %PYTHON_MSI% ALLUSERS=1 ADDDEFAULT=ALL
)
)

echo,
echo ------------------------------------------------------------------
echo Add Python to PATH
echo ------------------------------------------------------------------
echo,

rem reg add "HKCU\Environment" /v PATH /t REG_EXPAND_SZ /d "%PYTHON_PATH%"
rem reg add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Environment" /v PATH /t REG_EXPAND_SZ /d "%PATH%;c:\Python27;c:\Python27\Scripts"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH /t REG_EXPAND_SZ /d "%PATH%;%PYTHON_PATH%"


