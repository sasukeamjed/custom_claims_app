const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.createNewUser = functions.https.onCall(async (data, context) => {
    return addAdmin(data['email'], data['password'], data['phoneNumber'], data['fullName']);
});

const addAdmin = async (email, password, phoneNumber, fullName) => {
    return admin.auth().createUser({
        email: email,
        password: password,
        disabled: false,
        displayName: 'Admin',
        emailVerified: false,
        phoneNumber: '+968' + phoneNumber,
        photoURL: null,
    }).then(userData => {
        console.log(data);
        return admin.auth().setCustomUserClaims(userData.uid, { claim: 'admin' });
    }).catch(e => {
        console.log(e);
        return e;
    });
};
