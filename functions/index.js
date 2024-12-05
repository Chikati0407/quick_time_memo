// Cloud Functions 第2世代（公式で推奨）
const functions = require("firebase-functions/v2");

// 外部からアクセスできる関数を定義
exports.helloWorld = functions.https.onRequest((request, response) => {
  // Firebaseのログに出力
  functions.logger.info("Hello logs!", {structuredData: true});
  // レスポンスとして値を返す
  response.send("Hello from Firebase!");
});


