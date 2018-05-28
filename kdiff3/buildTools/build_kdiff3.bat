@echo off

set SRCROOT=%~d0%~p0..\..
set DEBUG_DIR=Debug
set RELEASE_DIR=Release

REM Set up Qt environment
set QTDIR=C:\Qt\Qt5.10.0\5.10.0\msvc2017_64
set PATH=%QTDIR%\bin;%PATH%

REM Set up Visual Studio environment variables.
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"
cd /d %SRCROOT%\kdiff3
qmake .\src-QT4\kdiff3.pro
nmake clean

powershell -ExecutionPolicy Bypass -File .\buildTools\setgitversion.ps1

if x%1==xdebug (
    if not exist %DEBUG_DIR% mkdir %DEBUG_DIR%
    copy %QTDIR%\bin\Qt5Cored.dll %DEBUG_DIR%
    copy %QTDIR%\bin\Qt5Guid.dll %DEBUG_DIR%
    copy %QTDIR%\bin\Qt5PrintSupportd.dll %DEBUG_DIR%
    copy %QTDIR%\bin\Qt5Widgetsd.dll %DEBUG_DIR%
    nmake debug
) else if not x%1==xclean (
    if not exist %RELEASE_DIR% mkdir %RELEASE_DIR%
    copy %QTDIR%\bin\Qt5Core.dll %RELEASE_DIR%
    copy %QTDIR%\bin\Qt5Gui.dll %RELEASE_DIR%
    copy %QTDIR%\bin\Qt5PrintSupport.dll %RELEASE_DIR%
    copy %QTDIR%\bin\Qt5Widgets.dll %RELEASE_DIR%
    nmake release
    nmake clean
)

git checkout %SRCROOT%\kdiff3\src-QT4\version.h
