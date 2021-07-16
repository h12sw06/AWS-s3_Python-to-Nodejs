::.bat 기본 세팅 값
  @echo off
  @chcp 65001
  set mypath=%cd%
  setx Auto_NODE_AND_PYTHON_INSTALL %mypath% -m
  cls

::설치 파일
  msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi
  start /d "%mypath%" /b node-v12.18.3-x64.msi
  start /d "%mypath%" /b picpick_inst_kr.exe
  start /d "%mypath%" /b python-3.7.9-amd64.exe
  start /d "%mypath%\오픈 소스 설치파일" /b tesseract_ocr_w64_setup-v5.0.0-alpha(20200328).exe

  start explorer.exe https://niceman.tistory.com/155

  start mspaint.exe "%mypath%\picpick설정\img_001.png"
  start mspaint.exe "%mypath%\picpick설정\img_002.png"
  start mspaint.exe "%mypath%\picpick설정\img_003.png"
  start mspaint.exe "%mypath%\picpick설정\img_004.png"


::완료대기
  echo.
  echo 설치가 모두 완료되면 아무키나 입력...
  echo (주의!! 재부팅하니 중요한 자료는 저장해 주세요!!)
  pause
  cls

reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "Auto_NODE_AND_PYTHON_INSTALL" /d "%mypath%\0.NODE,PYTHON자동설치.bat" /f

C:\Windows\System32\shutdown.exe /g /f /t 0