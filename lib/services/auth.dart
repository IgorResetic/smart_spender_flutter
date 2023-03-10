import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_spender/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // create user obj base on FirebaseUser
  UIUser? _userFromFirebaseUser(User? user) {
    return user != null ? UIUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UIUser?> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
}

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async{
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password
      );

      User? firebaseUser = result.user;

      return _userFromFirebaseUser(firebaseUser);

    } catch(e) {
      print(e.toString());
    }
  }

  // sign in with google
  Future signInWithGoogle() async {
    try {
      GoogleSignInAccount? result = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication = await result!.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(authCredential);
    } catch(e) {
      print(e);
    }
  }

  // sign out
  /*
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
    }
  }
   */
  Future<void> signOut() async{
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}