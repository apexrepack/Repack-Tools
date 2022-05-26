@echo off
color 0b
Title Compressor v2.0.2.2 - APEX
echo *******************************************************************************
echo *                    APEX Repack Data Compressor Tools v2.0.2.2               *
echo *                       Don't any files/folder renamed or edit.               *
echo *******************************************************************************
echo *                    Time:%time%     Date:%date%                 *
echo *******************************************************************************
pause
@echo Working Arc+Srep64+Lzma Only
arc a -lc8 -ep1 -ed -r -w.\ D:\APEX\Output\Setup-1.bin -msrep+lzma:a1:mfbt4:d512m:fb256:mc1000:lc8 "D:\APEX\GameData\Setup1\*"
cls
echo *******************************************************************************
echo.
echo                Compressing is Completed
echo.
echo *******************************************************************************
pause
