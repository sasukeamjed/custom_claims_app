const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.createNewUser = functions.https.onCall(async (data, context) => {
    return addAdmin(data['email'], data['phoneNumber'], data['fullName']);
});

exports.createShopOwner = functions.https.onCall(async => {
  return addShopOwner();
});

const addAdmin = async (email, phoneNumber, fullName) => {
    return admin.auth().createUser({
        email: email,
        password: '123456',
        disabled: false,
        displayName: 'Admin',
        emailVerified: false,
        phoneNumber: '+968' + phoneNumber,
        // photoURL: null,
    }).then(async (userData) => {
        // console.log(userData);
        return await admin.auth().setCustomUserClaims(userData.uid, { claim: 'admin' });
    }).catch(e => {
        console.log(e);
        return e;
    });
};

const addShopOwner = async (
    idToken,
    shopName,
    email,
    phoneNumber,
    shopOwnerName,
  ) => {
    var user;
    var shopsCollection = db.collection('Shops');
  
  
    return admin.auth().verifyIdToken(idToken).then(async (decodedToken) => {
      console.log(decodedToken);
  
      if (decodedToken.claim === 'Admin') {
  
        let doc = await shopsCollection.doc(shopName).get();
  
        if (doc.exists) {
          console.log('Shop Name already exist');
          throw new Error('Shop Name already exist');
        }
  
        return admin.auth().createUser({
          email: email,
          phoneNumber: '+968' + phoneNumber,
          emailVerified: false,
          password: '123456',
          displayName: shopName,
          photoURL: 'https://firebasestorage.googleapis.com/v0/b/fir-auth-test-a160f.appspot.com/o/default_shop_image.jpg?alt=media&token=70482119-01d4-4b38-b05c-f3c31be420fc',
          disabled: false
        });
  
      } else {
        throw new Error('Unauthrized line 104');
      }
  
    }).then(async (newUser) => {
      console.log('user was created with the following uid:' + newUser.uid);
      await admin.auth().setCustomUserClaims(newUser.uid, { claim: 'ShopOwner' });
      user = newUser;
      return {};
    }).then(() => {
      return shopsCollection.doc(shopName).set({
        shopName,
        shopOwnerName
      });
  
    }).then((res) => {
      console.log('user with ShopOwner claim was created!!! hope it worked');
      return user;
    }).catch(e => {
      console.log(e.message);
      if (e.message === '501') {
        return {
          error: e.message,
          message: 'this is a 501 error'
        }
      } else {
        return {
          error: e.message,
          message: 'this is a normal error'
        }
      }
    });
  
  
  };
