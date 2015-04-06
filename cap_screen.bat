@ECHO OFF
cd D:\software\boxcutter-1.5
:loop
set file_name=%date: =_%_%time::=_%
boxcutter.exe -f D:/file_name.png
goto loop