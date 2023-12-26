// import 'package:chat_app/models/UIHelper.dart';
// import 'package:chat_app/models/user_model.dart';
// import 'package:chat_app/pages/profile_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({Key? key}) : super(key: key);

//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController cPasswordController = TextEditingController();

//   void checkValues() {
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();
//     String cPassword = cPasswordController.text.trim();

//     if (email == "" || password == "" || cPassword == "") {
//       UIHelper.showAlertDialog(
//           context, "Incomplete Data", "Please fill all the fields");
//     } else if (password != cPassword) {
//       UIHelper.showAlertDialog(context, "Password Mismatch",
//           "The passwords you entered do not match!");
//     } else {
//       signUp(email, password);
//     }
//   }

//   void signUp(String email, String password) async {
//     UserCredential? credential;

//     UIHelper.showLoadingDialog(context, "Creating new account..");

//     try {
//       credential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch (ex) {
//       Navigator.pop(context);

//       UIHelper.showAlertDialog(
//           context, "An error occurred", ex.message.toString());
//     }

//     if (credential != null) {
//       String uid = credential.user!.uid;
//       UserModel newUser =
//           UserModel(uid: uid, email: email, fullname: "", profilePic: "");
//       await FirebaseFirestore.instance
//           .collection("users")
//           .doc(uid)
//           .set(newUser.toMap())
//           .then((value) {
//         print("New User Created!");
//         Navigator.popUntil(context, (route) => route.isFirst);
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) {
//             return ProfilePage(
//                 userModel: newUser, fireBaseUser: credential!.user!);
//           }),
//         );
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 40),
//           child: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Container(
//                         width: 60,
//                         height: 60,
//                         child: Image.asset("lib/images/icon.png"),
//                       ),
//                       SizedBox(width: 15),
//                       Text(
//                         "Chit-Chat",
//                         style: TextStyle(
//                           color: Color.fromARGB(255, 108, 3, 132),
//                           fontSize: 45,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 30),
//                   Card(
//                     elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.grey[200],
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 8.0),
//                               child: TextField(
//                                 controller: emailController,
//                                 decoration: InputDecoration(
//                                   labelText: "Email Address",
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.grey[200],
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 8.0),
//                               child: TextField(
//                                 controller: passwordController,
//                                 obscureText: true,
//                                 decoration: InputDecoration(
//                                   labelText: "Password",
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.grey[200],
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 8.0),
//                               child: TextField(
//                                 controller: cPasswordController,
//                                 obscureText: true,
//                                 decoration: InputDecoration(
//                                   labelText: "Confirm Password",
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           GestureDetector(
//                             onTap: () {
//                               checkValues();
//                             },
//                             child: Container(
//                               padding: EdgeInsets.all(20),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 gradient: LinearGradient(colors: [
//                                   Color.fromARGB(255, 235, 138, 240),
//                                   Color.fromARGB(255, 130, 12, 149),
//                                 ]),
//                                 color: Theme.of(context).colorScheme.secondary,
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   "Sign up",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Already have an account?",
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 CupertinoButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text(
//                                     "Log In",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 72, 2, 78),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:chat_app/main.dart';
// import 'package:chat_app/models/UIHelper.dart';
// import 'package:chat_app/models/user_model.dart';
// import 'package:chat_app/pages/profile_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({Key? key}) : super(key: key);

//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController cPasswordController = TextEditingController();

//   void checkValues() {
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();
//     String cPassword = cPasswordController.text.trim();

//     if (email == "" || password == "" || cPassword == "") {
//       UIHelper.showAlertDialog(
//           context, "Incomplete Data", "Please fill all the fields");
//     } else if (password != cPassword) {
//       UIHelper.showAlertDialog(context, "Password Mismatch",
//           "The passwords you entered do not match!");
//     } else {
//       signUp(email, password);
//     }
//   }

//   void signUp(String email, String password) async {
//     UserCredential? credential;

//     UIHelper.showLoadingDialog(context, "Creating new account..");

//     try {
//       credential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch (ex) {
//       Navigator.pop(context);

//       UIHelper.showAlertDialog(
//           context, "An error occurred", ex.message.toString());
//     }

//     if (credential != null) {
//       String uid = credential.user!.uid;
//       UserModel newUser =
//           UserModel(uid: uid, email: email, fullname: "", profilePic: "");
//       await FirebaseFirestore.instance
//           .collection("users")
//           .doc(uid)
//           .set(newUser.toMap())
//           .then((value) {
//         print("New User Created!");
//         Navigator.popUntil(context, (route) => route.isFirst);
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) {
//             return ProfilePage(
//                 userModel: newUser, fireBaseUser: credential!.user!);
//           }),
//         );
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 40),
//           child: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Container(
//                         width: 60,
//                         height: 60,
//                         child: Image.asset("lib/images/icon.png"),
//                       ),
//                       SizedBox(width: 15),
//                       Text(
//                         "Chit-Chat",
//                         style: TextStyle(
//                           color: Theme.of(context).colorScheme.primary,
//                           fontSize: 45,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 30),
//                   Card(
//                     elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 8.0),
//                               child: TextField(
//                                 controller: emailController,
//                                 decoration: InputDecoration(
//                                   labelText: "Email Address",
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 8.0),
//                               child: TextField(
//                                 controller: passwordController,
//                                 obscureText: true,
//                                 decoration: InputDecoration(
//                                   labelText: "Password",
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 8.0),
//                               child: TextField(
//                                 controller: cPasswordController,
//                                 obscureText: true,
//                                 decoration: InputDecoration(
//                                   labelText: "Confirm Password",
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           GestureDetector(
//                             onTap: () {
//                               checkValues();
//                             },
//                             child: Container(
//                               padding: EdgeInsets.all(20),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12),
//                                   gradient: kSecondaryGradient),
//                               child: Center(
//                                 child: Text(
//                                   "Sign up",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Already have an account?",
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 CupertinoButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text(
//                                     "Log In",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .secondary,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:chat_app/main.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/models/UIHelper.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/profile_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  double responsiveSize(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage / 100.0;
  }

  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || cPassword.isEmpty) {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else if (password != cPassword) {
      UIHelper.showAlertDialog(context, "Password Mismatch",
          "The passwords you entered do not match!");
    } else {
      signUp(email, password);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // The user canceled the sign-in process
        return Future.error("Google Sign-In canceled");
      }

      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.additionalUserInfo!.isNewUser) {
        // If it's a new user, fetch additional information and navigate to profile setup
        String email = userCredential.user!.email ?? "";
        String displayName = userCredential.user!.displayName ?? "";
        String photoURL = userCredential.user!.photoURL ?? "";

        UserModel newUser = UserModel(
          uid: userCredential.user!.uid,
          email: email,
          fullname: displayName,
          profilePic: photoURL,
        );

        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .set(newUser.toMap())
            .then((value) {
          print("New User Created by google sign in");
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) {
              return ProfilePage(
                  userModel: newUser, fireBaseUser: userCredential.user!);
            }),
          );
        });
      } else {
        // If it's an existing user, navigate to the home page
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            // Fetch user information if needed
            return HomePage(
                firebaseUser: userCredential.user!,
                userModel: UserModel.frommap({
                  'uid': userCredential.user!.uid,
                  'email': userCredential.user!.email,
                  'fullname': userCredential.user!.displayName,
                  'profilePic': userCredential.user!.photoURL,
                }));
          }),
        );
      }

      return userCredential;
    } catch (e) {
      return Future.error("Error signing in with Google: $e");
    }
  }

  // Future<UserCredential> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   if (googleUser == null) {
  //     // The user canceled the sign-in process
  //     return Future.error("Google Sign-In canceled");
  //   }

  //   try {
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );

  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);

  //     // Get user information from the GoogleSignInAccount
  //     String email = userCredential.user!.email ?? "";
  //     String displayName = userCredential.user!.displayName ?? "";
  //     String photoURL = userCredential.user!.photoURL ?? "";

  //     // Update the user model
  //     UserModel newUser = UserModel(
  //       uid: userCredential.user!.uid,
  //       email: email,
  //       fullname: displayName,
  //       profilePic: photoURL,
  //     );

  //     // Save the user model to Firestore
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(userCredential.user!.uid)
  //         .set(newUser.toMap())
  //         .then((value) {
  //       print("New User Created by google sign in");
  //       Navigator.popUntil(context, (route) => route.isFirst);
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) {
  //           return ProfilePage(
  //               userModel: newUser, fireBaseUser: userCredential.user!);
  //         }),
  //       );
  //     });

  //     // Return the updated UserCredential
  //     return userCredential;
  //   } catch (e) {
  //     return Future.error("Error signing in with Google: $e");
  //   }
  // }

  void signUp(String email, String password) async {
    UserCredential? credential;

    UIHelper.showLoadingDialog(context, "Creating new account..");

    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);

      UIHelper.showAlertDialog(
          context, "An error occurred", ex.message.toString());
    }

    if (credential != null) {
      String uid = credential.user!.uid;
      UserModel newUser =
          UserModel(uid: uid, email: email, fullname: "", profilePic: "");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(newUser.toMap())
          .then((value) {
        print("New User Created!");
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return ProfilePage(
                userModel: newUser, fireBaseUser: credential!.user!);
          }),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: responsiveSize(context, 8.0),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: responsiveSize(context, 2.0),
                      ),
                      Container(
                        width: responsiveSize(context, 15.0),
                        height: responsiveSize(context, 15.0),
                        child: Image.asset("lib/images/icon.png"),
                      ),
                      SizedBox(width: responsiveSize(context, 3.0)),
                      Text(
                        "Chit-Chat",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: responsiveSize(context, 6.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsiveSize(context, 6.0)),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        responsiveSize(context, 3.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                        responsiveSize(context, 4.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(
                                responsiveSize(context, 3.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: responsiveSize(context, 2.0),
                              ),
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: "Email Address",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: responsiveSize(context, 2.0)),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(
                                responsiveSize(context, 3.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: responsiveSize(context, 2.0),
                              ),
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: responsiveSize(context, 2.0)),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(
                                responsiveSize(context, 3.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: responsiveSize(context, 2.0),
                              ),
                              child: TextField(
                                controller: cPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Confirm Password",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: responsiveSize(context, 4.0)),
                          GestureDetector(
                            onTap: () {
                              checkValues();
                            },
                            child: Container(
                              padding: EdgeInsets.all(
                                responsiveSize(context, 4.0),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  responsiveSize(context, 3.0),
                                ),
                                gradient: kSecondaryGradient,
                              ),
                              child: Center(
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                    fontSize: responsiveSize(context, 5.0),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: responsiveSize(context, 4.0)),
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                signInWithGoogle();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                primary:
                                    Theme.of(context).colorScheme.onSecondary),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'lib/images/google_logo.png',
                                  height: 24.0,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  'Sign up with Google',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                    fontSize: responsiveSize(context, 3.0),
                                  ),
                                ),
                                CupertinoButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Log In",
                                    style: TextStyle(
                                      fontSize: responsiveSize(context, 3.0),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
