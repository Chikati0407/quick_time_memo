// Cloud Functions 第2世代（公式で推奨）
const functions = require("firebase-functions/v2")

// firebase-adminからfirestoreを代入
const admin = require("firebase-admin")

// firestore初期化
admin.initializeApp()
const firestore = admin.firestore()
const msg = admin.messaging()

// push通知メソッド
const pushMessage = (fcmToken, text) => ({
  notification: {
      title: '新しいオファーを受信しました。',
      body:  `${text}`,
  },
  apns: {
      headers: {
          'apns-priority': '10'
      },
      payload: {
          aps: {
              badge: 9999,
              sound: 'default'
          }
      }
  },
  data: {
      data: 'test',
  },
  token: fcmToken
});


// 関数
exports.mySendMeaasge = functions.region('asia-northeast1')
  .runWith({memory: "512MB"})
  .pubsub.schedule("every 5 minutes")
  .timeZone("Asia/Tokyo")
  .onRun(async (context) => {

    
  });
  


