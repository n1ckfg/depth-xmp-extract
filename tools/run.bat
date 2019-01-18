@echo off

cd %~dp0
C:\Util\exiftool.exe -Data -b %1 > depthmap.png

@pause