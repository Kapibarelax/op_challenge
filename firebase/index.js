
var admin = require("firebase-admin");

var serviceAccount = require("./op-challenge-dc21d-firebase-adminsdk-q79lb-674dea0d4f.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://op-challenge-dc21d.firebaseio.com"
});

const db = admin.firestore()
const fs = require('fs')
const csvSync = require('csv-parse/lib/sync')
const file = 'test2.csv' //インポートしたいcsvファイルをindex.jsと同じ階層に入れてください
let data = fs.readFileSync(file) //csvファイルの読み込み
let responses = csvSync(data)//parse csv
let objects = [] //この配列の中にパースしたcsvの中身をkey-value形式で入れていく。

responses.forEach(function(response) {
  objects.push({
    _id:             response[0],
    address:         response[1],
    category:        response[2],
    latitude:        response[3],
    link:            response[4],
    longuitude:      response[5],
    overview:        response[6],
    point:           response[7],
    review:          response[8],
    spot:            response[9]
  })
}, this)

objects.shift(); //ヘッダもインポートされてしまうから、配列の一番最初のelementは削除します。

return db.runTransaction(function(transaction){
  return transaction.get(db.collection('collectionName')).then(doc => {
    objects.forEach(function(object){
      if(object["_id"] != ""){
        let id = object["_id"]
        delete object._id
        transaction.set(db.collection('collectionName').doc(id), object)
      }else{
        delete object._id
        transaction.set(db.collection('collectionName').doc(), object)
      }
    }, this)
  })
}).then(function(){
  console.log("success")
}).catch(function(error){
  console.log('Failed', error)
})
