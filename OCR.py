print("--- PYTHON 시작 ---")

from botocore.exceptions import ClientError
from time import sleep
import pytesseract
import numpy as np
import boto3
import glob
import cv2
import os, glob

root_path = os.path.dirname(os.path.realpath(__file__))
image_path = 'Image_To_Text'
# count = 1

#tesseract 설치후 인식 안될시
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'

#이미지 인식 높이기 TEST
def unsharp_mask(image, kernel_size=(5, 5), sigma=1.0, amount=1.0, threshold=0):
    """Return a sharpened version of the image, using an unsharp mask."""
    blurred = cv2.GaussianBlur(image, kernel_size, sigma)
    sharpened = float(amount + 1) * image - float(amount) * blurred
    sharpened = np.maximum(sharpened, np.zeros(sharpened.shape))
    sharpened = np.minimum(sharpened, 255 * np.ones(sharpened.shape))
    sharpened = sharpened.round().astype(np.uint8)
    if threshold > 0:
        low_contrast_mask = np.absolute(image - blurred) < threshold
        np.copyto(sharpened, image, where=low_contrast_mask)
    return sharpened

#S3이미지 올리기
def create_s3_bucket(bucket_name):
    print("Creating a bucket... " + bucket_name)

    s3 = boto3.client(
        's3',  # 사용할 서비스 이름, ec2이면 'ec2', s3이면 's3', dynamodb이면 'dynamodb'
        aws_access_key_id="AKIAZHVRBGDNQH7BUEUX",         # 액세스 ID
        aws_secret_access_key="/goOZQ5KvCQ5SK+qIlJfMfchj86K0ZGF1f9JOQO9")    # 비밀 엑세스 키

    try:
        response = s3.create_bucket(
            Bucket=bucket_name,
            CreateBucketConfiguration={
                # Seoul  # us-east-1을 제외한 지역은 LocationConstraint 명시해야함.
                'LocationConstraint': 'ap-northeast-2'
            }
        )
        return response
    except ClientError as e:
        if e.response['Error']['Code'] == 'BucketAlreadyOwnedByYou':
            print("Bucket already exists. skipping..")
        else:
            print("Unknown error, exit..")

    for file,name in zip(files,stored_names):
        s3.upload_file(file,bucket_name,name)

while True:
    #스크린샷 위치
    screenshot=os.path.isfile(os.path.join(root_path,image_path,"image"+".png"))
    sleep(0.1)

    while screenshot:
        os.system('cls' if os.name == 'nt' else 'clear')
        print("--- PYTHON 시작 ---")

        screenshot=False
        #이미지 인식 높이기
        image = cv2.imread(os.path.join(root_path,image_path,"image"+".png"))

        height, width = image.shape[:2]
        image = cv2.resize(image, (2*width, 2*height), interpolation = cv2.INTER_CUBIC )
        image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

        #이미지 인식 높이기 TEST
        image_sharp = unsharp_mask(image)

        #이미지 인식(OCR)
        Processing=pytesseract.image_to_string(image, config='--psm 1 -c preserve_interword_spaces=1')
        print('가공전 : [\n\n',Processing,']\n')

        #OCR 가공
        texts = str(Processing).split("\n")
        print('가공후 :',texts)

        #이미지 출력
        # cv2.imshow("",image)
        # cv2.waitKey(0)
        # cv2.destroyAllWindows()

        #text파일 중복 체크
        # while True:
        #     img_to_text_path=os.path.join(root_path,image_path,"image.png"+".txt")
        #     print(count,os.path.isfile(img_to_text_path))
        #     if os.path.isfile(img_to_text_path):
        #         count+=1
        #     else:
        #         break

        #text파일로 저장
        f = open(os.path.join(root_path,image_path,"img-to-text"+".txt"),mode='wt',encoding="utf-8")

        #text 가공해서 저장
        for text in texts:
            if not(text is texts[-1]): 
                f.write(text+"\n")
        f.close()

        #AWS S3 파일 올리기       
        files = glob.glob(os.path.join(root_path,image_path,"*"))
        print(files)

        stored_names =  list(map(lambda x: x.split("\\")[-1], files))
        print(stored_names)

        response = create_s3_bucket(bucket_name="jne-chime-ocr")
        print("Bucket : " + str(response))

        #스크린샷 & OCR 파일 제거
        for file in files:
            os.remove(file)
        
        sleep(0.1)
