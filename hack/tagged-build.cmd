@echo off

set CURRENT_DIR=%cd%
set SCRIPT_DIR=%~dp0
cd %SCRIPT_DIR%\..

echo building tagged %1

cd services\%1
git rev-parse --short  HEAD > tag
set /P TAG=<  tag
del tag
set BUILD=jduimovich/%1:%TAG% 
echo building %BUILD%

echo docker build -t %BUILD% . 
docker build -t %BUILD% . 
echo docker push %BUILD% 
docker push %BUILD% 
cd %CURRENT_DIR%