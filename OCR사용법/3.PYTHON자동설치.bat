::.bat 기본 세팅 값
  @echo off
  @chcp 65001
  set mypath=%Auto_NODE_AND_PYTHON_INSTALL%
  cls

echo %mypath%


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
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Auto_NODE_AND_PYTHON_INSTALL /f

cls
echo.
echo --- PYTHON ---
python %mypath%\..\OCR.py
