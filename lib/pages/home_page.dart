// import 'package:chat_app/models/chat_room_model.dart';
// import 'package:chat_app/models/firebaseHelper.dart';
// import 'package:chat_app/models/user_model.dart';
// import 'package:chat_app/pages/chat_room_page.dart';
// import 'package:chat_app/pages/help_page.dart';
// import 'package:chat_app/pages/login_page.dart';
// import 'package:chat_app/pages/search_page.dart';
// import 'package:chat_app/widgets/drawer.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class HomePage extends StatefulWidget {
//   final User firebaseUser;
//   final UserModel userModel;

//   HomePage({Key? key, required this.firebaseUser, required this.userModel})
//       : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<String> selectedChatRooms = [];
//   bool isSelectionMode = false; // Track selection mode

//   String formatMessageTime(DateTime messageTimestamp) {
//     DateTime now = DateTime.now();
//     Duration difference = now.difference(messageTimestamp);

//     if (difference.inMinutes < 1) {
//       return 'Just now';
//     } else if (difference.inMinutes < 60) {
//       return '${difference.inMinutes} minutes ago';
//     } else if (difference.inHours < 24) {
//       return '${difference.inHours} hours ago';
//     } else {
//       return DateFormat('MMM dd, yyyy').format(messageTimestamp);
//     }
//   }

//   void toggleSelectionMode() {
//     setState(() {
//       // Toggle selection mode
//       isSelectionMode = !isSelectionMode;

//       if (!isSelectionMode) {
//         // Clear selected chat rooms when exiting selection mode
//         selectedChatRooms.clear();
//       }
//     });
//   }

//   void deleteSelectedChatRooms() {
//     for (String chatRoomId in selectedChatRooms) {
//       FirebaseHelper.deleteChatRoom(chatRoomId);
//     }
//     // Clear the selected chat rooms after deletion
//     setState(() {
//       selectedChatRooms.clear();
//       isSelectionMode = false; // Exit selection mode after deletion
//     });
//   }

//   void logOut() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             "Are you sure you want to logout?",
//             style: TextStyle(
//               color: Color.fromARGB(255, 250, 186, 249),
//             ),
//           ),
//           titleTextStyle: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//           actions: [
//             TextButton(
//                 child: Text(
//                   "No",
//                   style: TextStyle(
//                     color: Color.fromARGB(255, 250, 186, 249),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 }),
//             TextButton(
//                 child: Text(
//                   "Yes",
//                   style: TextStyle(
//                     color: Color.fromARGB(255, 250, 186, 249),
//                   ),
//                 ),
//                 onPressed: () {
//                   FirebaseAuth.instance.signOut();
//                   Navigator.pop(context);
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) {
//                       return LoginPage();
//                     }),
//                   );
//                 })
//           ],
//           backgroundColor: Color.fromARGB(255, 74, 31, 79),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: CustomDrawer(
//         userModel: widget.userModel,
//         firebaseUser: widget.firebaseUser,
//       ),
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 125, 9, 152),
//         centerTitle: true,
//         title: Text("Chats"),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               logOut();
//             },
//             icon: Icon(Icons.exit_to_app),
//           ),
//           PopupMenuButton(
//             itemBuilder: (BuildContext context) {
//               return [
//                 PopupMenuItem(child: Text("Delete"), value: 1),
//                 PopupMenuItem(child: Text("Mark all as read"), value: 2),
//                 PopupMenuItem(child: Text("Starred messages"), value: 3),
//                 PopupMenuItem(child: Text("Change labels"), value: 4),
//                 PopupMenuItem(child: Text("Mark important"), value: 5),
//                 PopupMenuItem(child: Text("Trash"), value: 6),
//                 PopupMenuItem(child: Text("Setting"), value: 7),
//                 PopupMenuItem(child: Text("Contact us"), value: 8),
//               ];
//             },
//             onSelected: (value) {
//               if (value == 1) {
//                 toggleSelectionMode(); // Enter selection mode for deletion
//               }
//               if (value == 8) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) {
//                     return HelpPage();
//                   }),
//                 );
//               }
//             },
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: Container(
//           child: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection("chatrooms")
//                 .where("participants.${widget.userModel.uid}", isEqualTo: true)
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.active) {
//                 if (snapshot.hasData) {
//                   QuerySnapshot chatRoomSnapshot =
//                       snapshot.data as QuerySnapshot;

//                   return ListView.builder(
//                     itemCount: chatRoomSnapshot.docs.length,
//                     itemBuilder: (context, index) {
//                       ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
//                           chatRoomSnapshot.docs[index].data()
//                               as Map<String, dynamic>);

//                       Map<String, dynamic> participants =
//                           chatRoomModel.participants!;

//                       List<String> participantKeys = participants.keys.toList();
//                       participantKeys.remove(widget.userModel.uid);

//                       return FutureBuilder(
//                         future:
//                             FirebaseHelper.getUserModelById(participantKeys[0]),
//                         builder: (context, userData) {
//                           if (userData.connectionState ==
//                               ConnectionState.done) {
//                             if (userData.data != null) {
//                               UserModel targetUser = userData.data as UserModel;
//                               String formattedTime =
//                                   formatMessageTime(chatRoomModel.createdon!);
//                               return Column(
//                                 children: [
//                                   ListTile(
//                                     onTap: () {
//                                       if (isSelectionMode) {
//                                         // Implement selection logic here
//                                         setState(() {
//                                           if (selectedChatRooms.contains(
//                                               chatRoomModel.chatroomid!)) {
//                                             selectedChatRooms.remove(
//                                                 chatRoomModel.chatroomid!);
//                                           } else {
//                                             selectedChatRooms
//                                                 .add(chatRoomModel.chatroomid!);
//                                           }
//                                         });
//                                       } else {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(builder: (context) {
//                                             return ChatRoomPage(
//                                               chatroom: chatRoomModel,
//                                               firebaseUser: widget.firebaseUser,
//                                               userModel: widget.userModel,
//                                               targetUser: targetUser,
//                                             );
//                                           }),
//                                         );
//                                       }
//                                     },
//                                     // Use a ternary operator to conditionally set the leading widget.
//                                     leading: isSelectionMode
//                                         ? Checkbox(
//                                             // Add a checkbox for selection
//                                             value: selectedChatRooms.contains(
//                                                 chatRoomModel.chatroomid!),
//                                             onChanged: (bool? value) {
//                                               setState(() {
//                                                 if (value != null && value) {
//                                                   selectedChatRooms.add(
//                                                       chatRoomModel
//                                                           .chatroomid!);
//                                                 } else {
//                                                   selectedChatRooms.remove(
//                                                       chatRoomModel
//                                                           .chatroomid!);
//                                                 }
//                                               });
//                                             },
//                                           )
//                                         : CircleAvatar(
//                                             backgroundImage: NetworkImage(
//                                               targetUser.profilePic!.toString(),
//                                             ),
//                                           ),
//                                     title: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           targetUser.fullname.toString(),
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                         Text(
//                                           formattedTime,
//                                           style: TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 98, 4, 95)),
//                                         ),
//                                       ],
//                                     ),
//                                     subtitle:
//                                         (chatRoomModel.lastMessage.toString() !=
//                                                 "")
//                                             ? Text(chatRoomModel.lastMessage
//                                                 .toString())
//                                             : Text(
//                                                 "Say hi to your new friend!",
//                                                 style: TextStyle(
//                                                   color: Color.fromARGB(
//                                                       255, 232, 4, 240),
//                                                 ),
//                                               ),
//                                   ),
//                                   Container(
//                                     width: 380,
//                                     child: Divider(
//                                       color: Color.fromARGB(255, 106, 106, 106),
//                                       thickness: 1,
//                                       height: 0,
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             } else {
//                               return Container();
//                             }
//                           } else {
//                             return Container();
//                           }
//                         },
//                       );
//                     },
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text(snapshot.error.toString()),
//                   );
//                 } else {
//                   return Center(
//                     child: Text("No Chats"),
//                   );
//                 }
//               } else {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//       floatingActionButton: isSelectionMode
//           ? FloatingActionButton(
//               backgroundColor: Colors.red, // Change delete button color
//               onPressed: deleteSelectedChatRooms, // Implement delete logic
//               child: Icon(Icons.delete),
//             )
//           : FloatingActionButton(
//               backgroundColor: Color.fromARGB(255, 125, 9, 152),
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   return SearchPage(
//                       userModel: widget.userModel,
//                       firebaseUser: widget.firebaseUser);
//                 }));
//               },
//               child: Icon(Icons.message),
//             ),
//     );
//   }
// }
// import 'package:chat_app/models/chat_room_model.dart';
// import 'package:chat_app/models/firebaseHelper.dart';
// import 'package:chat_app/models/user_model.dart';
// import 'package:chat_app/pages/chat_room_page.dart';
// import 'package:chat_app/pages/help_page.dart';
// import 'package:chat_app/pages/login_page.dart';
// import 'package:chat_app/pages/search_page.dart';
// import 'package:chat_app/widgets/drawer.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class HomePage extends StatefulWidget {
//   final User firebaseUser;
//   final UserModel userModel;

//   HomePage({Key? key, required this.firebaseUser, required this.userModel})
//       : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<String> selectedChatRooms = [];
//   bool isSelectionMode = false; // Track selection mode

//   String formatMessageTime(DateTime messageTimestamp) {
//     DateTime now = DateTime.now();
//     Duration difference = now.difference(messageTimestamp);

//     if (difference.inMinutes < 1) {
//       return 'Just now';
//     } else if (difference.inMinutes < 60) {
//       return '${difference.inMinutes} minutes ago';
//     } else if (difference.inHours < 24) {
//       return '${difference.inHours} hours ago';
//     } else {
//       return DateFormat('MMM dd, yyyy').format(messageTimestamp);
//     }
//   }

//   void toggleSelectionMode() {
//     setState(() {
//       // Toggle selection mode
//       isSelectionMode = !isSelectionMode;

//       if (!isSelectionMode) {
//         // Clear selected chat rooms when exiting selection mode
//         selectedChatRooms.clear();
//       }
//     });
//   }

//   void deleteSelectedChatRooms() {
//     for (String chatRoomId in selectedChatRooms) {
//       FirebaseHelper.deleteChatRoom(chatRoomId);
//     }
//     // Clear the selected chat rooms after deletion
//     setState(() {
//       selectedChatRooms.clear();
//       isSelectionMode = false; // Exit selection mode after deletion
//     });
//   }

//   void logOut() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             "Are you sure you want to logout?",
//             style: TextStyle(
//               color: Theme.of(context).colorScheme.onPrimary,
//             ),
//           ),
//           titleTextStyle: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//           actions: [
//             TextButton(
//                 child: Text(
//                   "No",
//                   style: TextStyle(
//                     color: Theme.of(context).colorScheme.onPrimary,
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 }),
//             TextButton(
//                 child: Text(
//                   "Yes",
//                   style: TextStyle(
//                     color: Theme.of(context).colorScheme.onSecondary,
//                   ),
//                 ),
//                 onPressed: () {
//                   FirebaseAuth.instance.signOut();
//                   Navigator.pop(context);
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) {
//                       return LoginPage();
//                     }),
//                   );
//                 })
//           ],
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: CustomDrawer(
//         userModel: widget.userModel,
//         firebaseUser: widget.firebaseUser,
//       ),
//       appBar: AppBar(
//         // backgroundColor: Theme.of(context).colorScheme.primary,
//         centerTitle: true,
//         title: Text("Chats"),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               logOut();
//             },
//             icon: Icon(Icons.exit_to_app),
//           ),
//           PopupMenuButton(
//             itemBuilder: (BuildContext context) {
//               return [
//                 PopupMenuItem(child: Text("Delete"), value: 1),
//                 PopupMenuItem(child: Text("Mark all as read"), value: 2),
//                 PopupMenuItem(child: Text("Starred messages"), value: 3),
//                 PopupMenuItem(child: Text("Change labels"), value: 4),
//                 PopupMenuItem(child: Text("Mark important"), value: 5),
//                 PopupMenuItem(child: Text("Trash"), value: 6),
//                 PopupMenuItem(child: Text("Setting"), value: 7),
//                 PopupMenuItem(child: Text("Contact us"), value: 8),
//               ];
//             },
//             onSelected: (value) {
//               if (value == 1) {
//                 toggleSelectionMode(); // Enter selection mode for deletion
//               }
//               if (value == 8) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) {
//                     return HelpPage();
//                   }),
//                 );
//               }
//             },
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: Container(
//           child: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection("chatrooms")
//                 .where("participants.${widget.userModel.uid}", isEqualTo: true)
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.active) {
//                 if (snapshot.hasData) {
//                   QuerySnapshot chatRoomSnapshot =
//                       snapshot.data as QuerySnapshot;

//                   return ListView.builder(
//                     itemCount: chatRoomSnapshot.docs.length,
//                     itemBuilder: (context, index) {
//                       ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
//                           chatRoomSnapshot.docs[index].data()
//                               as Map<String, dynamic>);

//                       Map<String, dynamic> participants =
//                           chatRoomModel.participants!;

//                       List<String> participantKeys = participants.keys.toList();
//                       participantKeys.remove(widget.userModel.uid);

//                       return FutureBuilder(
//                         future:
//                             FirebaseHelper.getUserModelById(participantKeys[0]),
//                         builder: (context, userData) {
//                           if (userData.connectionState ==
//                               ConnectionState.done) {
//                             if (userData.data != null) {
//                               UserModel targetUser = userData.data as UserModel;
//                               String formattedTime =
//                                   formatMessageTime(chatRoomModel.createdon!);
//                               return Column(
//                                 children: [
//                                   ListTile(
//                                     onTap: () {
//                                       if (isSelectionMode) {
//                                         // Implement selection logic here
//                                         setState(() {
//                                           if (selectedChatRooms.contains(
//                                               chatRoomModel.chatroomid!)) {
//                                             selectedChatRooms.remove(
//                                                 chatRoomModel.chatroomid!);
//                                           } else {
//                                             selectedChatRooms
//                                                 .add(chatRoomModel.chatroomid!);
//                                           }
//                                         });
//                                       } else {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(builder: (context) {
//                                             return ChatRoomPage(
//                                               chatroom: chatRoomModel,
//                                               firebaseUser: widget.firebaseUser,
//                                               userModel: widget.userModel,
//                                               targetUser: targetUser,
//                                             );
//                                           }),
//                                         );
//                                       }
//                                     },
//                                     // Use a ternary operator to conditionally set the leading widget.
//                                     leading: isSelectionMode
//                                         ? Checkbox(
//                                             // Add a checkbox for selection
//                                             value: selectedChatRooms.contains(
//                                                 chatRoomModel.chatroomid!),
//                                             onChanged: (bool? value) {
//                                               setState(() {
//                                                 if (value != null && value) {
//                                                   selectedChatRooms.add(
//                                                       chatRoomModel
//                                                           .chatroomid!);
//                                                 } else {
//                                                   selectedChatRooms.remove(
//                                                       chatRoomModel
//                                                           .chatroomid!);
//                                                 }
//                                               });
//                                             },
//                                           )
//                                         : CircleAvatar(
//                                             backgroundImage: NetworkImage(
//                                               targetUser.profilePic!.toString(),
//                                             ),
//                                           ),
//                                     title: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           targetUser.fullname.toString(),
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             // Adjust text color
//                                           ),
//                                         ),
//                                         Text(
//                                           formattedTime,
//                                           style: TextStyle(
//                                               color: Theme.of(context)
//                                                   .colorScheme
//                                                   .secondary),
//                                         ),
//                                       ],
//                                     ),
//                                     subtitle:
//                                         (chatRoomModel.lastMessage.toString() !=
//                                                 "")
//                                             ? Text(chatRoomModel.lastMessage
//                                                 .toString())
//                                             : Text(
//                                                 "Say hi to your new friend!",
//                                                 style: TextStyle(
//                                                   color: Theme.of(context)
//                                                       .colorScheme
//                                                       .secondary,
//                                                 ),
//                                               ),
//                                   ),
//                                   Container(
//                                     width: 380,
//                                     child: Divider(
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .secondary,
//                                       thickness: 1,
//                                       height: 0,
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             } else {
//                               return Container();
//                             }
//                           } else {
//                             return Container();
//                           }
//                         },
//                       );
//                     },
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text(snapshot.error.toString()),
//                   );
//                 } else {
//                   return Center(
//                     child: Text("No Chats"),
//                   );
//                 }
//               } else {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//       floatingActionButton: isSelectionMode
//           ? FloatingActionButton(
//               backgroundColor: Theme.of(context)
//                   .colorScheme
//                   .error, // Change delete button color
//               onPressed: deleteSelectedChatRooms, // Implement delete logic
//               child: Icon(Icons.delete),
//             )
//           : FloatingActionButton(
//               backgroundColor: Theme.of(context).colorScheme.primary,
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   return SearchPage(
//                       userModel: widget.userModel,
//                       firebaseUser: widget.firebaseUser);
//                 }));
//               },
//               child: Icon(Icons.message),
//             ),
//     );
//   }
// }
import 'package:chat_app/models/firebaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/chat_room_page.dart';
import 'package:chat_app/pages/help_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/search_page.dart';
import 'package:chat_app/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;

  HomePage({Key? key, required this.firebaseUser, required this.userModel})
      : super(key: key);

  double responsiveSize(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage / 100.0;
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> selectedChatRooms = [];
  bool isSelectionMode = false; // Track selection mode

  String formatMessageTime(DateTime messageTimestamp) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(messageTimestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return DateFormat('MMM dd, yyyy').format(messageTimestamp);
    }
  }

  void toggleSelectionMode() {
    setState(() {
      // Toggle selection mode
      isSelectionMode = !isSelectionMode;

      if (!isSelectionMode) {
        // Clear selected chat rooms when exiting selection mode
        selectedChatRooms.clear();
      }
    });
  }

  void deleteSelectedChatRooms() {
    for (String chatRoomId in selectedChatRooms) {
      FirebaseHelper.deleteChatRoom(chatRoomId);
    }
    // Clear the selected chat rooms after deletion
    setState(() {
      selectedChatRooms.clear();
      isSelectionMode = false; // Exit selection mode after deletion
    });
  }

  void logOut() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Are you sure you want to logout?",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          actions: [
            TextButton(
                child: Text(
                  "No",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            TextButton(
                child: Text(
                  "Yes",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }),
                  );
                })
          ],
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      drawer: CustomDrawer(
        userModel: widget.userModel,
        firebaseUser: widget.firebaseUser,
      ),
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text("Chats"),
        actions: [
          IconButton(
            onPressed: () async {
              logOut();
            },
            icon: Icon(Icons.exit_to_app),
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(child: Text("Delete"), value: 1),
                PopupMenuItem(child: Text("Mark all as read"), value: 2),
                PopupMenuItem(child: Text("Starred messages"), value: 3),
                PopupMenuItem(child: Text("Change labels"), value: 4),
                PopupMenuItem(child: Text("Mark important"), value: 5),
                PopupMenuItem(child: Text("Trash"), value: 6),
                PopupMenuItem(child: Text("Setting"), value: 7),
                PopupMenuItem(child: Text("Contact us"), value: 8),
              ];
            },
            onSelected: (value) {
              if (value == 1) {
                toggleSelectionMode(); // Enter selection mode for deletion
              }
              if (value == 8) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return HelpPage();
                  }),
                );
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("chatrooms")
                .where("participants.${widget.userModel.uid}", isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot chatRoomSnapshot =
                      snapshot.data as QuerySnapshot;

                  return ListView.builder(
                    itemCount: chatRoomSnapshot.docs.length,
                    itemBuilder: (context, index) {
                      ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                          chatRoomSnapshot.docs[index].data()
                              as Map<String, dynamic>);

                      Map<String, dynamic> participants =
                          chatRoomModel.participants!;

                      List<String> participantKeys = participants.keys.toList();
                      participantKeys.remove(widget.userModel.uid);

                      return FutureBuilder(
                        future:
                            FirebaseHelper.getUserModelById(participantKeys[0]),
                        builder: (context, userData) {
                          if (userData.connectionState ==
                              ConnectionState.done) {
                            if (userData.data != null) {
                              UserModel targetUser = userData.data as UserModel;
                              String formattedTime =
                                  formatMessageTime(chatRoomModel.createdon!);
                              return Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      if (isSelectionMode) {
                                        // Implement selection logic here
                                        setState(() {
                                          if (selectedChatRooms.contains(
                                              chatRoomModel.chatroomid!)) {
                                            selectedChatRooms.remove(
                                                chatRoomModel.chatroomid!);
                                          } else {
                                            selectedChatRooms
                                                .add(chatRoomModel.chatroomid!);
                                          }
                                        });
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return ChatRoomPage(
                                              chatroom: chatRoomModel,
                                              firebaseUser: widget.firebaseUser,
                                              userModel: widget.userModel,
                                              targetUser: targetUser,
                                            );
                                          }),
                                        );
                                      }
                                    },
                                    // Use a ternary operator to conditionally set the leading widget.
                                    leading: isSelectionMode
                                        ? Checkbox(
                                            // Add a checkbox for selection
                                            value: selectedChatRooms.contains(
                                                chatRoomModel.chatroomid!),
                                            onChanged: (bool? value) {
                                              setState(() {
                                                if (value != null && value) {
                                                  selectedChatRooms.add(
                                                      chatRoomModel
                                                          .chatroomid!);
                                                } else {
                                                  selectedChatRooms.remove(
                                                      chatRoomModel
                                                          .chatroomid!);
                                                }
                                              });
                                            },
                                          )
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              targetUser.profilePic!.toString(),
                                            ),
                                          ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          targetUser.fullname.toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            // Adjust text color
                                          ),
                                        ),
                                        Text(
                                          formattedTime,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                        ),
                                      ],
                                    ),
                                    subtitle:
                                        (chatRoomModel.lastMessage.toString() !=
                                                "")
                                            ? Text(chatRoomModel.lastMessage
                                                .toString())
                                            : Text(
                                                "Say hi to your new friend!",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                              ),
                                  ),
                                  Container(
                                    width: widget.responsiveSize(context, 380),
                                    child: Divider(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      thickness: 1,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          } else {
                            return Container();
                          }
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Center(
                    child: Text("No Chats"),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: isSelectionMode
          ? FloatingActionButton(
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .error, // Change delete button color
              onPressed: deleteSelectedChatRooms, // Implement delete logic
              child: Icon(Icons.delete),
            )
          : FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchPage(
                      userModel: widget.userModel,
                      firebaseUser: widget.firebaseUser);
                }));
              },
              child: Icon(Icons.message),
            ),
    );
  }
}
