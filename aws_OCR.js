console.log("--- NODE 시작 ---")
const AWS = require("aws-sdk");
const params = { Bucket: 'jne-chime-ocr', Key: 'img-to-text.txt' };

const SESConfig = {
  accessKeyId: "AKIAZHVRBGDNQH7BUEUX",      
  accessSecretKey: "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",  
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

