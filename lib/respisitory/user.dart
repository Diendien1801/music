// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class UserRepository {
//   final FirebaseAuth _firebaseAuth;
//   final GoogleSignIn _googleSignIn;
//   UserRepository({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
//       : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
//         _googleSignIn = googleSignIn ?? GoogleSignIn();

//   Future<void> signInWithEmailAndPassWord(String email, String password) async {
//     await _firebaseAuth.signInWithEmailAndPassword(
//         email: email.trim(), password: password.trim());
//   }

//   Future<void> createUserWithEmailAndPassWord(
//       String email, String password) async {
//     await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email.trim(), password: password);
//   }

//   Future<void> signOut() async {
//     await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
//   }

//   Future<bool> isSignIn() async {
//     return _firebaseAuth.currentUser != null;
//   }

//   Future<User> getUser() async {
//     return await _firebaseAuth.currentUser!;
//   }
// }
