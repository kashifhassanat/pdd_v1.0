

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User{
  final String uid;

  User({@required this.uid});
}

abstract class AuthBase{
    Future<User> signInWithGoogle();

  Future<User> currentUser();
  Future<void> signOut();
  Stream<User> get onAuthstateChanged;
  Future<User> signInWithFacbook() ;
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email,String password);
}

class Auth implements AuthBase {

final _firebaseAuth =FirebaseAuth.instance;

User _userFromFirebase(FirebaseUser user){
  if(user==null){
    return null;
  }
  return User(uid: user.uid);
}
Stream<User> get onAuthstateChanged{
  return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
}
@override
Future <User> currentUser() async {

final user = await _firebaseAuth.currentUser();
return _userFromFirebase(user);



}    
 @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }



 @override
  Future<User> signInWithGoogle() async {  
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
 
  
        );   await  Firestore.instance.collection("users")
    .document(authResult.user.uid).setData(
      {"uid": authResult.user.uid,
                                    "fname": authResult.user.displayName,
                                    "password":"_password" ,
                                    "email": authResult.user.email,
                                    "address":"_address"
    });
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }
@override
Future<User> signInWithFacbook() async{
  final facebookLogin = FacebookLogin();
  final result = await facebookLogin.logInWithReadPermissions(
    ['public_profile']);
    if(result.accessToken != null){
      final authResult= await FirebaseAuth.instance.signInWithCredential(
        FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token
        ));   await  Firestore.instance.collection("users")
    .document(authResult.user.uid).setData(
      {"uid": authResult.user.uid,
                                      "fname": "authResult.user.displayName",
                                    "password":"type password" ,
                                    "email": "type email",
                                    "address":"type address"
    });
        return _userFromFirebase(authResult.user);


  
  




    }
    else{
      throw PlatformException(code: "Error_Missing_Google_Auth_Token",
      message: "Missing Auth Token");
    }
}@override
Future<User> createUserWithEmailAndPassword(String email,String password) async{
  final authResult= await _firebaseAuth.
  createUserWithEmailAndPassword(email: email, password: password);
  return _userFromFirebase(authResult.user);
}


@override
Future <void> signOut() async {

 

 final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();


}

}