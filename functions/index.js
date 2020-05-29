const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//

exports.createNewUser = functions.https.onCall(async (data, context)=> {
  console.log(data['idToken']);
  if(data['idToken'] === undefined){
    console.log("add customer function is fired");
    return addCustomer(data['email'], data['password'],data['displayName'], data['phoneNumber']);
  }
  return addAdminOrShop(data['idToken'], data['displayName'], data['email'], data['phoneNumber'], data['fullName'], data['shopImageUrl']);
});




const addAdminOrShop = async(idToken, displayName, email, shopName, fullName, address, phoneNumber)=>{
  return admin.auth().verifyIdToken(idToken).then(async (decodedToken)=>{
    if(decodedToken.claim === 'admin'){
      if(shopName === null){
        return addAdmin(email, phoneNumber, fullName);
      }
      return addShop(displayName, email, phoneNumber, fullName, shopImageUrl, address);
    }else{
      throw new Error('Unauthrized line 72');
    }
  });
};


const addCustomer = async (email, password,cusotmerName ,phoneNumber)=>{
  return admin.auth().createUser({
    email: email,
    password: password,
    disabled: false,
    displayName: cusotmerName,
    emailVerified: false,
    phoneNumber: '+968' + phoneNumber,
    // photoURL: null,
  }).then(async (userData) => {
    // console.log(userData);
    return await admin.auth().setCustomUserClaims(userData.uid, { claim: 'customer' });
  }).catch(e => {
    console.log(e);
    return e;
  });
};

const addAdmin = async (email, phoneNumber, fullName) => {
  
  return admin.auth().createUser({
    displayName: fullName,
    email: email,
    phoneNumber: '+968' + phoneNumber,
    emailVerified: false,
    password: '123456',
    disabled: false
    }).then(async (newUser) => {

    console.log('user was created with the following uid:' + newUser.uid);
    await admin.auth().setCustomUserClaims(newUser.uid, { claim: 'admin' });
    user = newUser;
    return {};

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

const addShop = async (
  shopName,
  email,
  phoneNumber,
  fullName,
  shopImageUrl,
  address,
) => {
  var user;
  var shopsCollection = db.collection('Shops');

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
    photoURL: shopImageUrl,
    disabled: false
  }).then(async (newUser) => {
    console.log('user was created with the following uid:' + newUser.uid);
    await admin.auth().setCustomUserClaims(newUser.uid, { claim: 'shop' });
    user = newUser;
    return {};
  }).then(() => {

    return shopsCollection.doc(shopName).set({
      shopName,
      fullName,
      address,
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






