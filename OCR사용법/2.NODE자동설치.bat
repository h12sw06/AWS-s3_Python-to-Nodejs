::.bat 기본 세팅 값
  @echo off
  @chcp 65001
  set mypath=%Auto_NODE_AND_PYTHON_INSTALL%
  cls

echo %mypath%


echo.
echo --- NODE ---
::start notepad.exe "%mypath%\설명서.txt"
call npm install aws-sdk
call npm install -g @aws-amplify/cli
call amplify configure

timeout 10
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Auto_NODE_AND_PYTHON_INSTALL /f

cls
echo.
echo --- NODE ---
node %mypath%\..\aws_OCR.js

