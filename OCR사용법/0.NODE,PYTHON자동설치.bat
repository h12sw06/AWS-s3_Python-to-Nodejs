::.bat 기본 세팅 값
  @echo off
  @chcp 65001
  cls

start notepad.exe "%Auto_NODE_AND_PYTHON_INSTALL%\0.사용법.txt"
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "Auto_NODE_AND_PYTHON_INSTALL" /f

::python 자동설치
  start powershell -NoExit "%Auto_NODE_AND_PYTHON_INSTALL%\3.PYTHON자동설치.bat"

::node 자동설치
  start powershell -NoExit "%Auto_NODE_AND_PYTHON_INSTALL%\2.NODE자동설치.bat"
