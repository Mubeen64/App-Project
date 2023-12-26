// import 'dart:developer';
// import 'dart:io';
// import 'package:chat_app/models/UIHelper.dart';
// import 'package:chat_app/models/user_model.dart';
// import 'package:chat_app/pages/home_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class ProfilePage extends StatefulWidget {
//   final UserModel userModel;
//   final User fireBaseUser;
//   const ProfilePage(
//       {super.key, required this.userModel, required this.fireBaseUser});

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final TextEditingController fullNameController = TextEditingController();
//   File? imageFile;
//   bool _isLoading = false;

//   void showPhotoOptions() {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Upload Profile Picture"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ListTile(
//                   onTap: () {
//                     selectImage(ImageSource.gallery);
//                     Navigator.pop(context);
//                   },
//                   leading: Icon(Icons.photo_album),
//                   title: Text("Select from gallery"),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     selectImage(ImageSource.camera);
//                     Navigator.pop(context);
//                   },
//                   leading: Icon(Icons.camera_alt),
//                   title: Text("Take a picture"),
//                 )
//               ],
//             ),
//           );
//         });
//   }

//   void selectImage(ImageSource source) async {
//     XFile? pickedFile = await ImagePicker().pickImage(source: source);

//     if (pickedFile != null) {
//       cropImage(pickedFile);
//     }
//   }

//   void cropImage(XFile file) async {
//     CroppedFile? croppedImage = await ImageCropper().cropImage(
//       sourcePath: file.path,
//       aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
//       compressQuality: 20,
//     );
//     if (croppedImage! != null) {
//       imageFile = File(croppedImage.path);
//     }
//   }

//   Future<void> _uploadImageAndSaveProfile() async {
//     UIHelper.showLoadingDialog(context, "Updating profile");
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       UploadTask uploadTask = FirebaseStorage.instance
//           .ref('profilepictures')
//           .child(widget.userModel.uid.toString())
//           .putFile(imageFile!);

//       TaskSnapshot snapshot = await uploadTask;
//       String? imageUrl = await snapshot.ref.getDownloadURL();
//       String? fullName = fullNameController.text.trim();

//       widget.userModel.profilePic = imageUrl;
//       widget.userModel.fullname = fullName;

//       setState(() {
//         _isLoading = false;
//       });

//       await FirebaseFirestore.instance
//           .collection("users")
//           .doc(widget.userModel.uid)
//           .set(widget.userModel.toMap())
//           .then((value) {
//         log("Profile Updated");
//         Navigator.popUntil(context, (route) => route.isFirst);
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) {
//           return HomePage(
//               userModel: widget.userModel, firebaseUser: widget.fireBaseUser);
//         }));
//       });
//     } catch (error) {
//       showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//                 title: Text("Error setting up user profile: $error"),
//                 content: Text("Please try again"),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text("OK"),
//                   )
//                 ]);
//           });
//       setState(() {
//         _isLoading = false;
//       });
//       // Handle the error as needed
//     }
//   }

//   void checkValues() {
//     String fullname = fullNameController.text.trim();
//     if (fullname.isEmpty || imageFile == null) {
//       showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//                 title: Text("Please fill all the fields"),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text("OK"),
//                   )
//                 ]);
//           });
//     } else {
//       _uploadImageAndSaveProfile();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 125, 9, 152),
//         title: Text('User Profile Setup'),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   imageFile != null
//                       ? CircleAvatar(
//                           radius: 60,
//                           backgroundImage: FileImage(imageFile!),
//                         )
//                       : InkWell(
//                           onTap: showPhotoOptions,
//                           child: CircleAvatar(
//                             radius: 60,
//                             backgroundColor: Color.fromARGB(255, 125, 9, 152),
//                             child: Icon(
//                               Icons.person,
//                               size: 40,
//                               color: Colors.grey[800],
//                             ),
//                           ),
//                         ),
//                   SizedBox(height: 20),
//                   TextField(
//                     controller: fullNameController,
//                     decoration: InputDecoration(
//                       labelText: 'Full Name',
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: () {
//                       checkValues();
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         gradient: LinearGradient(
//                           colors: [
//                             Color.fromARGB(255, 235, 138, 240),
//                             Color.fromARGB(255, 130, 12, 149),
//                           ],
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Submit",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
// import 'dart:developer';
// import 'dart:io';
// import 'package:chat_app/models/UIHelper.dart';
// import 'package:chat_app/models/user_model.dart';
// import 'package:chat_app/pages/home_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:chat_app/main.dart';

// class ProfilePage extends StatefulWidget {
//   final UserModel userModel;
//   final User fireBaseUser;
//   const ProfilePage(
//       {super.key, required this.userModel, required this.fireBaseUser});

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final TextEditingController fullNameController = TextEditingController();
//   File? imageFile;
//   bool _isLoading = false;

//   void showPhotoOptions() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Upload Profile Picture"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 onTap: () {
//                   selectImage(ImageSource.gallery);
//                   Navigator.pop(context);
//                 },
//                 leading: Icon(Icons.photo_album),
//                 title: Text("Select from gallery"),
//               ),
//               ListTile(
//                 onTap: () {
//                   selectImage(ImageSource.camera);
//                   Navigator.pop(context);
//                 },
//                 leading: Icon(Icons.camera_alt),
//                 title: Text("Take a picture"),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void selectImage(ImageSource source) async {
//     XFile? pickedFile = await ImagePicker().pickImage(source: source);

//     if (pickedFile != null) {
//       cropImage(pickedFile);
//     }
//   }

//   void cropImage(XFile file) async {
//     CroppedFile? croppedImage = await ImageCropper().cropImage(
//       sourcePath: file.path,
//       aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
//       compressQuality: 20,
//     );
//     if (croppedImage != null) {
//       imageFile = File(croppedImage.path);
//     }
//   }

//   Future<void> _uploadImageAndSaveProfile() async {
//     UIHelper.showLoadingDialog(context, "Updating profile");
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       UploadTask uploadTask = FirebaseStorage.instance
//           .ref('profilepictures')
//           .child(widget.userModel.uid.toString())
//           .putFile(imageFile!);

//       TaskSnapshot snapshot = await uploadTask;
//       String? imageUrl = await snapshot.ref.getDownloadURL();
//       String? fullName = fullNameController.text.trim();

//       widget.userModel.profilePic = imageUrl;
//       widget.userModel.fullname = fullName;

//       setState(() {
//         _isLoading = false;
//       });

//       await FirebaseFirestore.instance
//           .collection("users")
//           .doc(widget.userModel.uid)
//           .set(widget.userModel.toMap())
//           .then((value) {
//         log("Profile Updated");
//         Navigator.popUntil(context, (route) => route.isFirst);
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) {
//               return HomePage(
//                   userModel: widget.userModel,
//                   firebaseUser: widget.fireBaseUser);
//             },
//           ),
//         );
//       });
//     } catch (error) {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Error setting up user profile: $error"),
//             content: Text("Please try again"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//       setState(() {
//         _isLoading = false;
//       });
//       // Handle the error as needed
//     }
//   }

//   void checkValues() {
//     String fullname = fullNameController.text.trim();
//     if (fullname.isEmpty || imageFile == null) {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Please fill all the fields"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       _uploadImageAndSaveProfile();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         title: Text('User Profile Setup'),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   imageFile != null
//                       ? CircleAvatar(
//                           radius: 60,
//                           backgroundImage: FileImage(imageFile!),
//                         )
//                       : InkWell(
//                           onTap: showPhotoOptions,
//                           child: CircleAvatar(
//                             radius: 60,
//                             backgroundColor:
//                                 Theme.of(context).colorScheme.primary,
//                             child: Icon(
//                               Icons.person,
//                               size: 40,
//                               color: Theme.of(context).colorScheme.onPrimary,
//                             ),
//                           ),
//                         ),
//                   SizedBox(height: 20),
//                   TextField(
//                     controller: fullNameController,
//                     decoration: InputDecoration(
//                       labelText: 'Full Name',
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: () {
//                       checkValues();
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         gradient: LinearGradient(
//                           colors: [
//                             Theme.of(context).colorScheme.secondary,
//                             Theme.of(context).colorScheme.primary,
//                           ],
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Submit",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Theme.of(context).colorScheme.onSecondary,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
import 'dart:developer';
import 'dart:io';
import 'package:chat_app/models/UIHelper.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:chat_app/main.dart';

class ProfilePage extends StatefulWidget {
  final UserModel userModel;
  final User fireBaseUser;
  const ProfilePage(
      {Key? key, required this.userModel, required this.fireBaseUser});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController fullNameController = TextEditingController();
  File? imageFile;
  bool _isLoading = false;

  void showPhotoOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Upload Profile Picture"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  selectImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                leading: Icon(Icons.photo_album),
                title: Text("Select from gallery"),
              ),
              ListTile(
                onTap: () {
                  selectImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                leading: Icon(Icons.camera_alt),
                title: Text("Take a picture"),
              )
            ],
          ),
        );
      },
    );
  }

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 20,
    );
    if (croppedImage != null) {
      imageFile = File(croppedImage.path);
    }
  }

  Future<void> _uploadImageAndSaveProfile() async {
    UIHelper.showLoadingDialog(context, "Updating profile");
    setState(() {
      _isLoading = true;
    });

    try {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('profilepictures')
          .child(widget.userModel.uid.toString())
          .putFile(imageFile!);

      TaskSnapshot snapshot = await uploadTask;
      String? imageUrl = await snapshot.ref.getDownloadURL();
      String? fullName = fullNameController.text.trim();

      widget.userModel.profilePic = imageUrl;
      widget.userModel.fullname = fullName;

      setState(() {
        _isLoading = false;
      });

      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.userModel.uid)
          .set(widget.userModel.toMap())
          .then((value) {
        log("Profile Updated");
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage(
                  userModel: widget.userModel,
                  firebaseUser: widget.fireBaseUser);
            },
          ),
        );
      });
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error setting up user profile: $error"),
            content: Text("Please try again"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      setState(() {
        _isLoading = false;
      });
      // Handle the error as needed
    }
  }

  double responsiveSize(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage / 100.0;
  }

  void checkValues() {
    String fullname = fullNameController.text.trim();
    if (fullname.isEmpty || imageFile == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Please fill all the fields"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      _uploadImageAndSaveProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('User Profile Setup'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(responsiveSize(context, 5.0)),
              child: Column(
                children: [
                  imageFile != null
                      ? CircleAvatar(
                          radius: responsiveSize(context, 15.0),
                          backgroundImage: FileImage(imageFile!),
                        )
                      : InkWell(
                          onTap: showPhotoOptions,
                          child: CircleAvatar(
                            radius: responsiveSize(context, 15.0),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: Icon(
                              Icons.person,
                              size: responsiveSize(context, 8.0),
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                  SizedBox(height: responsiveSize(context, 2.0)),
                  TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                    ),
                  ),
                  SizedBox(height: responsiveSize(context, 2.0)),
                  GestureDetector(
                    onTap: () {
                      checkValues();
                    },
                    child: Container(
                      padding: EdgeInsets.all(responsiveSize(context, 5.0)),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(responsiveSize(context, 2.0)),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.secondary,
                            Theme.of(context).colorScheme.primary,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: responsiveSize(context, 4.0),
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
