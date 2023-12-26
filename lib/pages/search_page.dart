// import 'package:chat_app/main.dart';
// import 'package:chat_app/models/chat_room_model.dart';
// import 'package:chat_app/models/user_model.dart';
// import 'package:chat_app/pages/chat_room_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class SearchPage extends StatefulWidget {
//   final UserModel userModel;
//   final User firebaseUser;
//   const SearchPage(
//       {super.key, required this.userModel, required this.firebaseUser});

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   TextEditingController searchController = TextEditingController();

//   Future<ChatRoomModel?> getChatroomModel(UserModel targetUser) async {
//     ChatRoomModel? chatRoom;

//     QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection("chatrooms")
//         .where("participants.${widget.userModel.uid}", isEqualTo: true)
//         .where("participants.${targetUser.uid}", isEqualTo: true)
//         .get();

//     if (snapshot.docs.isNotEmpty) {
//       // Fetch the existing one
//       var docData = snapshot.docs[0].data();
//       ChatRoomModel existingChatroom =
//           ChatRoomModel.fromMap(docData as Map<String, dynamic>);

//       chatRoom = existingChatroom;
//     } else {
//       // Create a new one
//       ChatRoomModel newChatroom = ChatRoomModel(
//         chatroomid: uuid.v1(),
//         lastMessage: "",
//         participants: {
//           widget.userModel.uid.toString(): true,
//           targetUser.uid.toString(): true,
//         },
//         users: [widget.userModel.uid.toString(), targetUser.uid.toString()],
//         createdon: DateTime.now(),
//       );

//       await FirebaseFirestore.instance
//           .collection("chatrooms")
//           .doc(newChatroom.chatroomid)
//           .set(newChatroom.toMap());

//       chatRoom = newChatroom;

//       print("New Chatroom Created!");
//     }

//     return chatRoom;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 125, 9, 152),
//         // title: Text("Find.."),
//       ),
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 10,
//           ),
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     border: Border.all(color: Colors.white),
//                     borderRadius: BorderRadius.circular(12)),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 8.0),
//                   child: TextField(
//                     controller: searchController,
//                     decoration: InputDecoration(
//                         labelText: "Email Address", border: InputBorder.none),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {});
//                 },
//                 child: Container(
//                   width: 225,
//                   height: 60,
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     gradient: LinearGradient(
//                       colors: [
//                         Color.fromARGB(255, 235, 138, 240),
//                         Color.fromARGB(255, 107, 5, 123),
//                       ],
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Search",
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               StreamBuilder(
//                   stream: FirebaseFirestore.instance
//                       .collection("users")
//                       .where("email", isEqualTo: searchController.text)
//                       .where("email", isNotEqualTo: widget.userModel.email)
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.active) {
//                       if (snapshot.hasData) {
//                         QuerySnapshot dataSnapshot =
//                             snapshot.data as QuerySnapshot;

//                         if (dataSnapshot.docs.length > 0) {
//                           Map<String, dynamic> userMap = dataSnapshot.docs[0]
//                               .data() as Map<String, dynamic>;

//                           UserModel searchedUser = UserModel.frommap(userMap);

//                           return ListTile(
//                             onTap: () async {
//                               ChatRoomModel? chatroomModel =
//                                   await getChatroomModel(searchedUser);

//                               if (chatroomModel != null) {
//                                 Navigator.pop(context);
//                                 Navigator.push(context,
//                                     MaterialPageRoute(builder: (context) {
//                                   return ChatRoomPage(
//                                     targetUser: searchedUser,
//                                     userModel: widget.userModel,
//                                     firebaseUser: widget.firebaseUser,
//                                     chatroom: chatroomModel,
//                                   );
//                                 }));
//                               }
//                             },
//                             leading: CircleAvatar(
//                               backgroundImage:
//                                   NetworkImage(searchedUser.profilePic!),
//                               backgroundColor: Colors.grey[500],
//                             ),
//                             title: Text(searchedUser.fullname!),
//                             subtitle: Text(searchedUser.email!),
//                             trailing: Icon(Icons.keyboard_arrow_right),
//                           );
//                         } else {
//                           return Text("No results found!");
//                         }
//                       } else if (snapshot.hasError) {
//                         return Text("An error occured!");
//                       } else {
//                         return Text("No results found!");
//                       }
//                     } else {
//                       return CircularProgressIndicator();
//                     }
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:chat_app/main.dart';
// import 'package:chat_app/models/chat_room_model.dart';
// import 'package:chat_app/models/user_model.dart';
// import 'package:chat_app/pages/chat_room_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class SearchPage extends StatefulWidget {
//   final UserModel userModel;
//   final User firebaseUser;

//   const SearchPage({
//     super.key,
//     required this.userModel,
//     required this.firebaseUser,
//   });

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   TextEditingController searchController = TextEditingController();

//   Future<ChatRoomModel?> getChatroomModel(UserModel targetUser) async {
//     ChatRoomModel? chatRoom;

//     QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection("chatrooms")
//         .where("participants.${widget.userModel.uid}", isEqualTo: true)
//         .where("participants.${targetUser.uid}", isEqualTo: true)
//         .get();

//     if (snapshot.docs.isNotEmpty) {
//       // Fetch the existing one
//       var docData = snapshot.docs[0].data();
//       ChatRoomModel existingChatroom =
//           ChatRoomModel.fromMap(docData as Map<String, dynamic>);

//       chatRoom = existingChatroom;
//     } else {
//       // Create a new one
//       ChatRoomModel newChatroom = ChatRoomModel(
//         chatroomid: uuid.v1(),
//         lastMessage: "",
//         participants: {
//           widget.userModel.uid.toString(): true,
//           targetUser.uid.toString(): true,
//         },
//         users: [widget.userModel.uid.toString(), targetUser.uid.toString()],
//         createdon: DateTime.now(),
//       );

//       await FirebaseFirestore.instance
//           .collection("chatrooms")
//           .doc(newChatroom.chatroomid)
//           .set(newChatroom.toMap());

//       chatRoom = newChatroom;

//       print("New Chatroom Created!");
//     }

//     return chatRoom;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.primary,
//       ),
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 10,
//           ),
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.surface,
//                   border:
//                       Border.all(color: Theme.of(context).colorScheme.primary),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 8.0),
//                   child: TextField(
//                     controller: searchController,
//                     decoration: InputDecoration(
//                       labelText: "Email Address",
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {});
//                 },
//                 child: Container(
//                   width: 225,
//                   height: 60,
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     gradient: LinearGradient(
//                       colors: [
//                         Theme.of(context).colorScheme.secondary,
//                         Theme.of(context).colorScheme.primary,
//                       ],
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Search",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Theme.of(context).colorScheme.onPrimary,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection("users")
//                     .where("email", isEqualTo: searchController.text)
//                     .where("email", isNotEqualTo: widget.userModel.email)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.active) {
//                     if (snapshot.hasData) {
//                       QuerySnapshot dataSnapshot =
//                           snapshot.data as QuerySnapshot;

//                       if (dataSnapshot.docs.length > 0) {
//                         Map<String, dynamic> userMap =
//                             dataSnapshot.docs[0].data() as Map<String, dynamic>;

//                         UserModel searchedUser = UserModel.frommap(userMap);

//                         return ListTile(
//                           onTap: () async {
//                             ChatRoomModel? chatroomModel =
//                                 await getChatroomModel(searchedUser);

//                             if (chatroomModel != null) {
//                               Navigator.pop(context);
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) {
//                                 return ChatRoomPage(
//                                   targetUser: searchedUser,
//                                   userModel: widget.userModel,
//                                   firebaseUser: widget.firebaseUser,
//                                   chatroom: chatroomModel,
//                                 );
//                               }));
//                             }
//                           },
//                           leading: CircleAvatar(
//                             backgroundImage:
//                                 NetworkImage(searchedUser.profilePic!),
//                             backgroundColor: Colors.grey[500],
//                           ),
//                           title: Text(
//                             searchedUser.fullname!,
//                             style: TextStyle(
//                               color: Theme.of(context).colorScheme.onPrimary,
//                             ),
//                           ),
//                           subtitle: Text(
//                             searchedUser.email!,
//                             style: TextStyle(
//                               color: Theme.of(context).colorScheme.secondary,
//                             ),
//                           ),
//                           trailing: Icon(
//                             Icons.keyboard_arrow_right,
//                             color: Theme.of(context).colorScheme.secondary,
//                           ),
//                         );
//                       } else {
//                         return Text("No results found!");
//                       }
//                     } else if (snapshot.hasError) {
//                       return Text("An error occurred!");
//                     } else {
//                       return Text("No results found!");
//                     }
//                   } else {
//                     return CircularProgressIndicator();
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/chat_room_page.dart';

class SearchPage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const SearchPage({
    Key? key,
    required this.userModel,
    required this.firebaseUser,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  double responsiveSize(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage / 100.0;
  }

  Future<ChatRoomModel?> getChatroomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("participants.${widget.userModel.uid}", isEqualTo: true)
        .where("participants.${targetUser.uid}", isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Fetch the existing one
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);

      chatRoom = existingChatroom;
    } else {
      // Create a new one
      ChatRoomModel newChatroom = ChatRoomModel(
        chatroomid: uuid.v1(),
        lastMessage: "",
        participants: {
          widget.userModel.uid.toString(): true,
          targetUser.uid.toString(): true,
        },
        users: [widget.userModel.uid.toString(), targetUser.uid.toString()],
        createdon: DateTime.now(),
      );

      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(newChatroom.chatroomid)
          .set(newChatroom.toMap());

      chatRoom = newChatroom;

      print("New Chatroom Created!");
    }

    return chatRoom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: responsiveSize(context, 5.0),
            vertical: responsiveSize(context, 2.0),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(
                    responsiveSize(context, 2.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: responsiveSize(context, 2.0),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: responsiveSize(context, 2.0),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  width: responsiveSize(context, 40.0),
                  height: responsiveSize(context, 12.0),
                  padding: EdgeInsets.all(
                    responsiveSize(context, 2.0),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      responsiveSize(context, 2.0),
                    ),
                    gradient: kSecondaryGradient,
                  ),
                  child: Center(
                    child: Text(
                      "Search",
                      style: TextStyle(
                        fontSize: responsiveSize(context, 4.0),
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: responsiveSize(context, 2.0),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where("email", isEqualTo: searchController.text)
                    .where("email", isNotEqualTo: widget.userModel.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot dataSnapshot =
                          snapshot.data as QuerySnapshot;

                      if (dataSnapshot.docs.length > 0) {
                        Map<String, dynamic> userMap =
                            dataSnapshot.docs[0].data() as Map<String, dynamic>;

                        UserModel searchedUser = UserModel.frommap(userMap);

                        return ListTile(
                          onTap: () async {
                            ChatRoomModel? chatroomModel =
                                await getChatroomModel(searchedUser);

                            if (chatroomModel != null) {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ChatRoomPage(
                                      targetUser: searchedUser,
                                      userModel: widget.userModel,
                                      firebaseUser: widget.firebaseUser,
                                      chatroom: chatroomModel,
                                    );
                                  },
                                ),
                              );
                            }
                          },
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(searchedUser.profilePic!),
                            backgroundColor: Colors.grey[500],
                          ),
                          title: Text(
                            searchedUser.fullname!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          subtitle: Text(
                            searchedUser.email!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        );
                      } else {
                        return Text("No results found!");
                      }
                    } else if (snapshot.hasError) {
                      return Text("An error occurred!");
                    } else {
                      return Text("No results found!");
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
