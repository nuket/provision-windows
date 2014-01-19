@echo off

set PYTHON_VERSION=2.7.6
set PYTHON_MSI=python-%PYTHON_VERSION%.msi
set PYTHON_EXE=c:\Python27\python.exe
set PYTHON_PATH=c:\Python27;c:\Python27\Scripts
set PYTHON_APPDATA=c:\Python27\AppData

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
    msiexec.exe /qb /i %PYTHON_MSI% ALLUSERS=1 ADDLOCAL=ALL
) else (
    echo Python installer package didn't seem to download correctly.
    exit /b 1
)
)

echo,
echo ------------------------------------------------------------------
echo Add Python to PATH
echo ------------------------------------------------------------------
echo,

rem Add the PYTHON_PATH to the PATH environment variable.

rem reg add "HKCU\Environment" /v PATH /t REG_EXPAND_SZ /d "%PYTHON_PATH%"
rem reg add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Environment" /v PATH /t REG_EXPAND_SZ /d "%PATH%;c:\Python27;c:\Python27\Scripts"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /f /v PATH /t REG_EXPAND_SZ /d "%PATH%;%PYTHON_PATH%"

rem Set LOCALAPPDATA to APPDATA, otherwise distlib will throw errors.
rem See: https://vilimpoc.org/blog/2014/01/18/time-robbing-python-errors/

mkdir %PYTHON_APPDATA%
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" /f /v LOCALAPPDATA /t REG_SZ /d "%PYTHON_APPDATA%"

rem Temporarily set LOCALAPPDATA.
set LOCALAPPDATA=%PYTHON_APPDATA%

rem Temporarily set the path, so we can use the python command.
set PATH=%PATH%;%PYTHON_PATH%

echo,
echo ------------------------------------------------------------------
echo Add easy_install
echo ------------------------------------------------------------------
echo,

curl -O https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
python ez_setup.py

echo,
echo ------------------------------------------------------------------
echo Add pip
echo ------------------------------------------------------------------
echo,

curl -O https://raw.github.com/pypa/pip/master/contrib/get-pip.py
python get-pip.py

echo,
echo ------------------------------------------------------------------
echo Add virtualenv
echo ------------------------------------------------------------------
echo,

pip install virtualenv

echo,
echo ------------------------------------------------------------------
echo Python %PYTHON_VERSION%, easy_install, pip, and virtualenv are 
echo now installed!
echo ------------------------------------------------------------------
echo,
