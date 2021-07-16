# AWS-s3_Python-to-Nodejs

1.windows 10에서 구동하였습니다.

2.오픈 소스 tesseract로 구현 했습니다.

3.자동설치 프로그램 만들었습니다.('0.사용법' 참조)  
(자동시작 계속 나올시 참고 : 
관리자 권한으로 cmd 또는 powershell ->  
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "Auto_NODE_AND_PYTHON_INSTALL" /f  
-> '작업을 완료 했습니다' 나오면 성공)
　  
　  
https://all-share-source-code.tistory.com/15
#### 궁금한점 있으면 사이트 댓글 주세요

--------------------------------------------

## 사용법(수동 설치 방법)  

1.

다운 받은곳 안에 '오픈 소스 설치파일' tesseract-ocr-w64-setup-v5.0.0-alpha.20200328.exe 설치 진행 해줍니다.

참고 : tesseract 설치 방법

https://junyoung-jamong.github.io/computer/vision,/ocr/2019/01/30/Python%EC%97%90%EC%84%9C-Tesseract%EB%A5%BC-%EC%9D%B4%EC%9A%A9%ED%95%B4-OCR-%EC%88%98%ED%96%89%ED%95%98%EA%B8%B0.html

https://m.blog.naver.com/samsjang/220694855018

https://niceman.tistory.com/155

#

2.

OCR.py 설치할것들

python.exe -m pip install --upgrade pip --user --no-warn-script-location

참고 : AWS(s3) No module named httpsession 문제 발생시

https://jojoldu.tistory.com/426

pip install awscli --user --force-reinstall --upgrade --ignore-installed --no-warn-script-location

pip install botocore

pip install pytesseract

pip install numpy

참고 : 파이썬 64비트 일경우 numpy 설치법

https://tiboy.tistory.com/603

numpy 설치 파일들

https://www.lfd.uci.edu/~gohlke/pythonlibs/#numpy

pip install boto3

pip install opencv-python

#

3.

aws_OCR.js 설치할것들

sudo npm install -g @aws-amplify/cli

amplify configure

amplify init

amplify push

#

4-1.aws_OCR.js 먼저 실행후 OCR.py 실행

4-2.픽픽(캡처도구)사용하여 'Image_To_Text'폴더위치로 저장하고 image.png로 자동 저장

4-3.픽픽에 영역 지정하여 사진 캡처

4-4.aws_OCR.js 캡처한 단어 또는 문장이 잘 출력되는지 확인

중요!! : AWS(S3)를 연결했기 때문에 S3가 꼭있어야함
