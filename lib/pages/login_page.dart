// import 'package:chat_app/models/UIHelper.dart';
// import 'package:chat_app/models/user_model.dart';
// import 'package:chat_app/pages/home_page.dart';
// import 'package:chat_app/pages/signup_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   void checkValues() {
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();

//     if (email == "" || password == "") {
//       UIHelper.showAlertDialog(
//           context, "Incomplete Data", "Please fill all the fields");
//     } else {
//       logIn(email, password);
//     }
//   }

//   void logIn(String email, String password) async {
//     UserCredential? credential;

//     UIHelper.showLoadingDialog(context, "Logging In..");

//     try {
//       credential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch (ex) {
//       // Close the loading dialog
//       Navigator.pop(context);

//       // Show Alert Dialog
//       UIHelper.showAlertDialog(
//           context, "An error occurred", ex.message.toString());
//     }

//     if (credential != null) {
//       String uid = credential.user!.uid;

//       DocumentSnapshot userData =
//           await FirebaseFirestore.instance.collection('users').doc(uid).get();
//       UserModel userModel =
//           UserModel.frommap(userData.data() as Map<String, dynamic>);

//       // Go to HomePage
//       print("Log In Successful!");
//       Navigator.popUntil(context, (route) => route.isFirst);
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//         return HomePage(userModel: userModel, firebaseUser: credential!.user!);
//       }));
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
//                                 obscureText: true,
//                                 controller: passwordController,
//                                 decoration: InputDecoration(
//                                   labelText: "Password",
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
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Color.fromARGB(255, 235, 138, 240),
//                                     Color.fromARGB(255, 130, 12, 149),
//                                   ],
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   "Log In",
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
//                                   "Don't have an account?",
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 CupertinoButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(builder: (context) {
//                                         return SignUpPage();
//                                       }),
//                                     );
//                                   },
//                                   child: Text(
//                                     "Sign Up",
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
// import 'package:chat_app/pages/home_page.dart';
// import 'package:chat_app/pages/signup_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   void checkValues() {
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();

//     if (email == "" || password == "") {
//       UIHelper.showAlertDialog(
//           context, "Incomplete Data", "Please fill all the fields");
//     } else {
//       logIn(email, password);
//     }
//   }

//   void logIn(String email, String password) async {
//     UserCredential? credential;

//     UIHelper.showLoadingDialog(context, "Logging In..");

//     try {
//       credential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch (ex) {
//       // Close the loading dialog
//       Navigator.pop(context);

//       // Show Alert Dialog
//       UIHelper.showAlertDialog(
//           context, "An error occurred", ex.message.toString());
//     }

//     if (credential != null) {
//       String uid = credential.user!.uid;

//       DocumentSnapshot userData =
//           await FirebaseFirestore.instance.collection('users').doc(uid).get();
//       UserModel userModel =
//           UserModel.frommap(userData.data() as Map<String, dynamic>);

//       // Go to HomePage
//       print("Log In Successful!");
//       Navigator.popUntil(context, (route) => route.isFirst);
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//         return HomePage(userModel: userModel, firebaseUser: credential!.user!);
//       }));
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
//                                 obscureText: true,
//                                 controller: passwordController,
//                                 decoration: InputDecoration(
//                                   labelText: "Password",
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
//                                   "Log In",
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
//                                   "Don't have an account?",
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 CupertinoButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(builder: (context) {
//                                         return SignUpPage();
//                                       }),
//                                     );
//                                   },
//                                   child: Text(
//                                     "Sign Up",
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/models/UIHelper.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/signup_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  double responsiveSize(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage / 100.0;
  }

  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else {
      logIn(email, password);
    }
  }

  void logIn(String email, String password) async {
    UserCredential? credential;

    UIHelper.showLoadingDialog(context, "Logging In..");

    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      // Close the loading dialog
      Navigator.pop(context);

      // Show Alert Dialog
      UIHelper.showAlertDialog(
          context, "An error occurred", ex.message.toString());
    }

    if (credential != null) {
      String uid = credential.user!.uid;

      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      UserModel userModel =
          UserModel.frommap(userData.data() as Map<String, dynamic>);

      // Go to HomePage
      print("Log In Successful!");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomePage(userModel: userModel, firebaseUser: credential!.user!);
      }));
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // The user canceled the sign-in process
      return Future.error("Google Sign-In canceled");
    }

    try {
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      String uid = userCredential.user!.uid;

      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      UserModel userModel =
          UserModel.frommap(userData.data() as Map<String, dynamic>);

      // Go to HomePage
      print("Google Log In Successful!");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomePage(
            userModel: userModel, firebaseUser: userCredential.user!);
      }));

      return userCredential;
    } catch (e) {
      return Future.error("Error signing in with Google: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: responsiveSize(context, 10.0),
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
                          fontSize: responsiveSize(context, 12.0),
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
                                obscureText: true,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: "Password",
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
                                  "Log In",
                                  style: TextStyle(
                                    fontSize: responsiveSize(context, 5.0),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: responsiveSize(context, 2.0)),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                await signInWithGoogle();
                              } catch (e) {
                                print("Error signing in with Google: $e");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary:
                                  Theme.of(context).colorScheme.onSecondary,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'lib/images/google_logo.png',
                                  height: 24.0,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  'Sign in with Google',
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
                                  "Don't have an account?",
                                  style: TextStyle(
                                    fontSize: responsiveSize(context, 3.0),
                                  ),
                                ),
                                CupertinoButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return SignUpPage();
                                      }),
                                    );
                                  },
                                  child: Text(
                                    "Sign Up",
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
