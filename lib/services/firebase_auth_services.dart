// // import 'package:firebase_auth/firebase_auth.dart';

// // class FireBaseAuthService {
// //   FirebaseAuth _auth = FirebaseAuth.instance;

// //   Future<User?> signUpWithEmailAndPassword(
// //       String email, String password) async {
// //     User? user;
// //     try {
// //       UserCredential userCredential = await _auth
// //           .createUserWithEmailAndPassword(email: email, password: password);
// //       user = userCredential.user;
// //     } on FirebaseAuthException catch (e) {
// //       if (e.code == 'weak-password') {
// //         print('The password provided is too weak.');
// //       } else if (e.code == 'email-already-in-use') {
// //         print('The account already exists for that email.');
// //       }
// //     } catch (e) {
// //       print(e);
// //     }
// //     return user;
// //   }

// //   Future<User?> signInWithEmailAndPassword(
// //       String email, String password) async {
// //     User? user;
// //     try {
// //       UserCredential userCredential = await _auth
// //           .signInWithEmailAndPassword(email: email, password: password);
// //       user = userCredential.user;
// //     } on FirebaseAuthException catch (e) {
// //       if (e.code == 'weak-password') {
// //         print('The password provided is too weak.');
// //       } else if (e.code == 'email-already-in-use') {
// //         print('The account already exists for that email.');
// //       }
// //     } catch (e) {
// //       print(e);
// //     }
// //     return user;
// //   }
// // }
// import 'package:chat_app/models/user_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class FirebaseAuthService {
//   FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<User?> signUpWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       UserCredential credential = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       if (credential.user != null) {
//         String uid = credential.user!.uid;
//         UserModel userModel =
//             UserModel(fullname: "", email: email, profilePic: "", uid: uid);
//         await FirebaseFirestore.instance
//             .collection("users")
//             .doc(uid)
//             .set(userModel.toMap());
//       }
//       return credential.user;
//     } catch (e) {
//       print("Some error occured");
//     }
//     return null;
//   }

//   Future<User?> signInWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       UserCredential credential = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       if (credential.user != null) {
//         String uid = credential.user!.uid;
//         DocumentSnapshot userData =
//             await FirebaseFirestore.instance.collection('users').doc(uid).get();
//         UserModel userModel =
//             UserModel.frommap(userData.data() as Map<String, dynamic>);
//       }
//       return credential.user;
//     } catch (e) {
//       print("Some error occured");
//     }
//     return null;
//   }
// }
