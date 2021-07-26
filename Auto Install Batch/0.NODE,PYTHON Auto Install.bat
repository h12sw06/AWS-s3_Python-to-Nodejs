::.bat 기본 세팅 값
  @echo off
  @chcp 65001
  cls

:CheckUAC
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    goto UACAccess
) else ( goto Done )

:UACAccess
echo 관리자 권한을 취득해야 합니다.
pause
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "cmd", "/c """"%~f0"" """ + Wscript.Arguments.Item(0) + """ ""%user%""""", "%CD%", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs" "%file%"
del "%temp%\getadmin.vbs"
exit /b

:Done
::--- 여기서부터 코드 입력 ---

start notepad.exe "%Auto_NODE_AND_PYTHON_INSTALL%\..\OCR사용법\0.사용법.txt"

timeout 3
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "Auto_NODE_AND_PYTHON_INSTALL" /f
cls

echo --- 관리자 권한을 취득하였습니다. ---
echo 아무키나 입력하면 다음 설치로 이동 합니다.
pause
::python 자동설치
  start cmd /k "%Auto_NODE_AND_PYTHON_INSTALL%3.PYTHON자동설치.bat"

::node 자동설치
  start cmd /k "%Auto_NODE_AND_PYTHON_INSTALL%2.NODE자동설치.bat"
exit
