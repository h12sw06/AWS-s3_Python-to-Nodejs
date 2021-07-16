console.log("--- NODE 시작 ---")
const AWS = require("aws-sdk");
const params = { Bucket: '버킷이름', Key: 'img-to-text.txt' };

const SESConfig = {
  accessKeyId: "액세스 ID",      
  accessSecretKey: "비밀 엑세스 키",  
  region: "ap-northeast-2"
}
AWS.config.update(SESConfig);
const s3 = new AWS.S3({apiVersion: "2010-12-01"});

function intervalFunc() {
  console.clear();
  console.log("--- NODE 시작 ---")

  try {
    s3.getObject(params, function (err, data) {
      if (err) {
        console.log(err, err.stack); // an error occurred
      }
      else {
        console.log(data.Body.toString('utf-8'));
      }
    });
  } catch (error) {
    console.log(error);
    console.log("S3 버킷을 확인해주세요...");
  }

}

setInterval(intervalFunc, 1000);

