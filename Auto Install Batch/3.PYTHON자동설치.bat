::.bat 기본 세팅 값
  @echo off
  @chcp 65001
  set mypath=%Auto_NODE_AND_PYTHON_INSTALL%
  cls

echo.
echo --- PYTHON ---
python -m pip install --upgrade pip --no-warn-script-location
pip install awscli --user --force-reinstall --upgrade --ignore-installed --no-warn-script-location
pip install botocore
pip install pytesseract
pip install numpy
pip install boto3
pip install opencv-python

timeout 10

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
echo --- 관리자 권한을 취득하였습니다. ---

echo.
echo 시작프로그램 삭제2
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Auto_NODE_AND_PYTHON_INSTALL /f
cls

echo.
echo --- PYTHON ---
echo 아무키나 입력하면 Python시작!!
pause

cls
python "%mypath%..\OCR.py"
