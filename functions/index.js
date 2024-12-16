const functions = require("firebase-functions/v1");
const admin = require("firebase-admin");

const { Timestamp } = require("firebase-admin/firestore");

admin.initializeApp();
const firestore = admin.firestore();




exports.scheduledFunction = functions.pubsub.schedule("every 5 minutes").onRun( async (context)  => {
  const now = Date.now();
  const now5 = now + 300000;

  const fcm_token_snap = await firestore.collection("token").doc("now_token").get();
  fcm_token = fcm_token_snap.data["token"];

  const snapshot = await firestore.collection("todo").get();

  snapshot.docs.forEach(async (doc) => {
    const data = doc.data();
    const time = Number(data.time.seconds) * 1000;

    if (now < time && time < now5){

      const pushMSG = {
        notification: {
          title: `${data["title"]}`,
          body:  `${data["content"]}`,
        },
        apns: {
          payload: {
              aps: {
                  sound: 'default'
              }
          }
        },
        data: {
          data: doc.id,
        },
  
        token: fcm_token,
    
      }
  
      admin.messaging().send(pushMSG);

    }
  });
});


// exports.testFunction = functions.https.onRequest(async (request, response) => {
//   const now = Date.now();
//   const now5 = now + 300000;



//   const snapshot = await firestore.collection("todo").get();

//   snapshot.docs.forEach(async (doc) => {
//     const data = doc.data();
//     const time = Number(data.time.seconds) * 1000;


//     if (now < time && time < now5){

//       const pushMSG = {
//         notification: {
//           title: `${data["title"]}`,
//           body:  `${data["content"]}`,
//         },
//         apns: {
//           payload: {
//               aps: {
//                   sound: 'default'
//               }
//           }
//         },
//         data: {
//           data: 'test',
//         },
  
//         token: fcm_token,
    
//       }
  
//       admin.messaging().send(pushMSG);

//     }
//   });

  
// });