var admin = require("firebase-admin");

var serviceAccount = require("./op-challenge-dc21d-firebase-adminsdk-q79lb-674dea0d4f.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://op-challenge-dc21d.firebaseio.com"
});

const db = admin.firestore()

let jaran = db.collection('collectionName').doc('id1');
let getDoc = jaran.get()
  .then(doc => {
    if (!doc.exists) {
      console.log('No such document!');
    } else {
      console.log('Document data:', doc.data());
    }
  })
  .catch(err => {
    console.log('Error getting document', err);
  });
