// import 'dart:developer';
// import 'package:chat_app/main.dart';
// import 'package:chat_app/models/chat_room_model.dart';
// import 'package:chat_app/models/message_model.dart';
// import 'package:chat_app/models/user_model.dart';
// import 'package:chat_app/pages/participant_detail.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ChatRoomPage extends StatefulWidget {
//   final UserModel targetUser;
//   final ChatRoomModel chatroom;
//   final UserModel userModel;
//   final User firebaseUser;

//   const ChatRoomPage(
//       {Key? key,
//       required this.targetUser,
//       required this.chatroom,
//       required this.userModel,
//       required this.firebaseUser})
//       : super(key: key);

//   @override
//   _ChatRoomPageState createState() => _ChatRoomPageState();
// }

// class _ChatRoomPageState extends State<ChatRoomPage> {
//   TextEditingController messageController = TextEditingController();

//   void sendMessage() async {
//     String msg = messageController.text.trim();
//     messageController.clear();

//     if (msg != "") {
//       // Send Message
//       MessageModel newMessage = MessageModel(
//           messageid: uuid.v1(),
//           sender: widget.userModel.uid,
//           createon: DateTime.now(),
//           text: msg,
//           seen: false);

//       FirebaseFirestore.instance
//           .collection("chatrooms")
//           .doc(widget.chatroom.chatroomid)
//           .collection("messages")
//           .doc(newMessage.messageid)
//           .set(newMessage.toMap());

//       widget.chatroom.lastMessage = msg;
//       FirebaseFirestore.instance
//           .collection("chatrooms")
//           .doc(widget.chatroom.chatroomid)
//           .set(widget.chatroom.toMap());

//       log("Message Sent!");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           const IconButton(
//             onPressed: null,
//             icon: Icon(Icons.call),
//           ),
//           const IconButton(
//             onPressed: null,
//             icon: Icon(Icons.video_call_rounded),
//           ),
//           PopupMenuButton(
//             itemBuilder: (context) {
//               return [
//                 PopupMenuItem(child: Text("View Contact"), value: 1),
//                 PopupMenuItem(child: Text("Mute Notifications"), value: 2),
//                 PopupMenuItem(child: Text("Disappearing Messages"), value: 3),
//               ];
//             },
//             onSelected: (value) {
//               if (value == 1) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return ParticipantDetail(
//                         userModel: widget.userModel,
//                         firebaseUser: widget.firebaseUser,
//                         targetUser: widget.targetUser,
//                         chatroom: widget.chatroom,
//                       );
//                     },
//                   ),
//                 );
//               }
//             },
//           )
//         ],
//         backgroundColor: Color.fromARGB(255, 125, 9, 152),
//         title: GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return ParticipantDetail(
//                 userModel: widget.userModel,
//                 firebaseUser: widget.firebaseUser,
//                 targetUser: widget.targetUser,
//                 chatroom: widget.chatroom,
//               );
//             }));
//           },
//           child: Container(
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Color.fromARGB(255, 91, 2, 80),
//                   backgroundImage:
//                       NetworkImage(widget.targetUser.profilePic.toString()),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(widget.targetUser.fullname.toString()),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             children: [
//               // This is where the chats will go
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection("chatrooms")
//                         .doc(widget.chatroom.chatroomid)
//                         .collection("messages")
//                         .orderBy("createon", descending: true)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.active) {
//                         if (snapshot.hasData) {
//                           QuerySnapshot dataSnapshot =
//                               snapshot.data as QuerySnapshot;

//                           return ListView.builder(
//                             reverse: true,
//                             itemCount: dataSnapshot.docs.length,
//                             itemBuilder: (context, index) {
//                               MessageModel currentMessage =
//                                   MessageModel.fromMap(dataSnapshot.docs[index]
//                                       .data() as Map<String, dynamic>);

//                               return Row(
//                                 mainAxisAlignment: (currentMessage.sender ==
//                                         widget.userModel.uid)
//                                     ? MainAxisAlignment.end
//                                     : MainAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                       margin: EdgeInsets.symmetric(
//                                         vertical: 5,
//                                         horizontal: 10,
//                                       ),
//                                       padding: EdgeInsets.symmetric(
//                                         vertical: 10,
//                                         horizontal: 10,
//                                       ),
//                                       decoration: BoxDecoration(
//                                           gradient: (currentMessage.sender ==
//                                                   widget.userModel.uid)
//                                               ? LinearGradient(
//                                                   colors: [
//                                                     Color.fromARGB(
//                                                         255, 108, 3, 132),
//                                                     Color.fromARGB(
//                                                         255, 228, 116, 215),
//                                                   ],
//                                                 )
//                                               : LinearGradient(
//                                                   colors: [
//                                                     Color.fromARGB(
//                                                         255, 137, 132, 138),
//                                                     Color.fromARGB(
//                                                         255, 189, 188, 189),
//                                                   ],
//                                                 ),
//                                           color: (currentMessage.sender !=
//                                                   widget.userModel.uid)
//                                               ? Color.fromARGB(
//                                                   255, 105, 104, 104)
//                                               : null, // No fallback color when condition is met
//                                           borderRadius: (currentMessage
//                                                       .sender ==
//                                                   widget.userModel.uid)
//                                               ? BorderRadius.only(
//                                                   topLeft: Radius.circular(10),
//                                                   topRight: Radius.circular(10),
//                                                   bottomLeft:
//                                                       Radius.circular(10),
//                                                 )
//                                               : BorderRadius.only(
//                                                   bottomLeft:
//                                                       Radius.circular(10),
//                                                   topRight: Radius.circular(10),
//                                                   bottomRight:
//                                                       Radius.circular(10),
//                                                 )),
//                                       child: Text(
//                                         currentMessage.text.toString(),
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           color: Colors.white,
//                                         ),
//                                       )),
//                                 ],
//                               );
//                             },
//                           );
//                         } else if (snapshot.hasError) {
//                           return Center(
//                             child: Text(
//                                 "An error occured! Please check your internet connection."),
//                           );
//                         } else {
//                           return Center(
//                             child: Text("Say hi to your new friend"),
//                           );
//                         }
//                       } else {
//                         return Center(
//                           child: CircularProgressIndicator(
//                               color: Color.fromARGB(255, 108, 3, 132)),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.75,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         color: Color.fromARGB(255, 228, 226, 228)),
//                     margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                     child: Row(
//                       children: [
//                         Flexible(
//                           child: TextField(
//                             controller: messageController,
//                             maxLines: null,
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: "Enter message"),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Color.fromARGB(255, 108, 3, 132),
//                     ),
//                     child: IconButton(
//                       onPressed: () {
//                         sendMessage();
//                       },
//                       icon: Icon(
//                         Icons.send,
//                         color: Color.fromARGB(255, 243, 241, 245),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'dart:developer';
// import 'package:chat_app/main.dart';
// import 'package:chat_app/models/chat_room_model.dart';
// import 'package:chat_app/models/message_model.dart';
// import 'package:chat_app/models/user_model.dart';
// import 'package:chat_app/pages/participant_detail.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ChatRoomPage extends StatefulWidget {
//   final UserModel targetUser;
//   final ChatRoomModel chatroom;
//   final UserModel userModel;
//   final User firebaseUser;

//   const ChatRoomPage({
//     Key? key,
//     required this.targetUser,
//     required this.chatroom,
//     required this.userModel,
//     required this.firebaseUser,
//   }) : super(key: key);

//   @override
//   _ChatRoomPageState createState() => _ChatRoomPageState();
// }

// class _ChatRoomPageState extends State<ChatRoomPage> {
//   TextEditingController messageController = TextEditingController();

//   void sendMessage() async {
//     String msg = messageController.text.trim();
//     messageController.clear();

//     if (msg != "") {
//       // Send Message
//       MessageModel newMessage = MessageModel(
//         messageid: uuid.v1(),
//         sender: widget.userModel.uid,
//         createon: DateTime.now(),
//         text: msg,
//         seen: false,
//       );

//       FirebaseFirestore.instance
//           .collection("chatrooms")
//           .doc(widget.chatroom.chatroomid)
//           .collection("messages")
//           .doc(newMessage.messageid)
//           .set(newMessage.toMap());

//       widget.chatroom.lastMessage = msg;
//       FirebaseFirestore.instance
//           .collection("chatrooms")
//           .doc(widget.chatroom.chatroomid)
//           .set(widget.chatroom.toMap());

//       log("Message Sent!");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           const IconButton(
//             onPressed: null,
//             icon: Icon(Icons.call),
//           ),
//           const IconButton(
//             onPressed: null,
//             icon: Icon(Icons.video_call_rounded),
//           ),
//           PopupMenuButton(
//             itemBuilder: (context) {
//               return [
//                 PopupMenuItem(child: Text("View Contact"), value: 1),
//                 PopupMenuItem(child: Text("Mute Notifications"), value: 2),
//                 PopupMenuItem(child: Text("Disappearing Messages"), value: 3),
//               ];
//             },
//             onSelected: (value) {
//               if (value == 1) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return ParticipantDetail(
//                         userModel: widget.userModel,
//                         firebaseUser: widget.firebaseUser,
//                         targetUser: widget.targetUser,
//                         chatroom: widget.chatroom,
//                       );
//                     },
//                   ),
//                 );
//               }
//             },
//           )
//         ],
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         title: GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return ParticipantDetail(
//                 userModel: widget.userModel,
//                 firebaseUser: widget.firebaseUser,
//                 targetUser: widget.targetUser,
//                 chatroom: widget.chatroom,
//               );
//             }));
//           },
//           child: Container(
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   backgroundColor:
//                       Theme.of(context).colorScheme.primaryContainer,
//                   backgroundImage:
//                       NetworkImage(widget.targetUser.profilePic.toString()),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(widget.targetUser.fullname.toString()),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             children: [
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection("chatrooms")
//                         .doc(widget.chatroom.chatroomid)
//                         .collection("messages")
//                         .orderBy("createon", descending: true)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.active) {
//                         if (snapshot.hasData) {
//                           QuerySnapshot dataSnapshot =
//                               snapshot.data as QuerySnapshot;

//                           return ListView.builder(
//                             reverse: true,
//                             itemCount: dataSnapshot.docs.length,
//                             itemBuilder: (context, index) {
//                               MessageModel currentMessage =
//                                   MessageModel.fromMap(dataSnapshot.docs[index]
//                                       .data() as Map<String, dynamic>);

//                               return Row(
//                                 mainAxisAlignment: (currentMessage.sender ==
//                                         widget.userModel.uid)
//                                     ? MainAxisAlignment.end
//                                     : MainAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     margin: EdgeInsets.symmetric(
//                                       vertical: 5,
//                                       horizontal: 10,
//                                     ),
//                                     padding: EdgeInsets.symmetric(
//                                       vertical: 10,
//                                       horizontal: 10,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       gradient: (currentMessage.sender ==
//                                               widget.userModel.uid)
//                                           ? kSecondaryGradient
//                                           : LinearGradient(colors: [
//                                               const Color.fromARGB(
//                                                   255, 76, 74, 74),
//                                               const Color.fromARGB(
//                                                   255, 168, 159, 159)
//                                             ]),
//                                       color: (currentMessage.sender !=
//                                               widget.userModel.uid)
//                                           ? Colors.grey
//                                           : null,
//                                       borderRadius: (currentMessage.sender ==
//                                               widget.userModel.uid)
//                                           ? BorderRadius.only(
//                                               topLeft: Radius.circular(10),
//                                               topRight: Radius.circular(10),
//                                               bottomLeft: Radius.circular(10),
//                                             )
//                                           : BorderRadius.only(
//                                               bottomLeft: Radius.circular(10),
//                                               topRight: Radius.circular(10),
//                                               bottomRight: Radius.circular(10),
//                                             ),
//                                     ),
//                                     child: Text(
//                                       currentMessage.text.toString(),
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         } else if (snapshot.hasError) {
//                           return Center(
//                             child: Text(
//                               "An error occurred! Please check your internet connection.",
//                             ),
//                           );
//                         } else {
//                           return Center(
//                             child: Text("Say hi to your new friend"),
//                           );
//                         }
//                       } else {
//                         return Center(
//                           child: CircularProgressIndicator(
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.75,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                     margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                     child: Row(
//                       children: [
//                         Flexible(
//                           child: TextField(
//                             controller: messageController,
//                             maxLines: null,
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: "Enter message",
//                                 hintStyle: TextStyle(
//                                   color: Theme.of(context)
//                                       .colorScheme
//                                       .onPrimaryContainer,
//                                 )),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                     child: IconButton(
//                       onPressed: () {
//                         sendMessage();
//                       },
//                       icon: Icon(
//                         Icons.send,
//                         color: Theme.of(context).colorScheme.onPrimaryContainer,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:developer';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/participant_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoomPage extends StatefulWidget {
  final UserModel targetUser;
  final ChatRoomModel chatroom;
  final UserModel userModel;
  final User firebaseUser;

  const ChatRoomPage({
    Key? key,
    required this.targetUser,
    required this.chatroom,
    required this.userModel,
    required this.firebaseUser,
  }) : super(key: key);

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  TextEditingController messageController = TextEditingController();

  double responsiveDesign(BuildContext context, double value) {
    return value;
  }

  void sendMessage() async {
    String msg = messageController.text.trim();
    messageController.clear();

    if (msg != "") {
      // Send Message
      MessageModel newMessage = MessageModel(
        messageid: uuid.v1(),
        sender: widget.userModel.uid,
        createon: DateTime.now(),
        text: msg,
        seen: false,
      );

      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatroom.chatroomid)
          .collection("messages")
          .doc(newMessage.messageid)
          .set(newMessage.toMap());

      widget.chatroom.lastMessage = msg;
      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatroom.chatroomid)
          .set(widget.chatroom.toMap());

      log("Message Sent!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.call),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.video_call_rounded),
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(child: Text("View Contact"), value: 1),
                PopupMenuItem(child: Text("Mute Notifications"), value: 2),
                PopupMenuItem(child: Text("Disappearing Messages"), value: 3),
              ];
            },
            onSelected: (value) {
              if (value == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ParticipantDetail(
                        userModel: widget.userModel,
                        firebaseUser: widget.firebaseUser,
                        targetUser: widget.targetUser,
                        chatroom: widget.chatroom,
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ParticipantDetail(
                userModel: widget.userModel,
                firebaseUser: widget.firebaseUser,
                targetUser: widget.targetUser,
                chatroom: widget.chatroom,
              );
            }));
          },
          child: Container(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  backgroundImage:
                      NetworkImage(widget.targetUser.profilePic.toString()),
                ),
                SizedBox(
                  width: responsiveDesign(context, 8),
                ),
                Flexible(
                  child: Text(
                    widget.targetUser.fullname.toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsiveDesign(context, 10),
                  ),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("chatrooms")
                        .doc(widget.chatroom.chatroomid)
                        .collection("messages")
                        .orderBy("createon", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          QuerySnapshot dataSnapshot =
                              snapshot.data as QuerySnapshot;

                          return ListView.builder(
                            reverse: true,
                            itemCount: dataSnapshot.docs.length,
                            itemBuilder: (context, index) {
                              MessageModel currentMessage =
                                  MessageModel.fromMap(dataSnapshot.docs[index]
                                      .data() as Map<String, dynamic>);

                              return Row(
                                mainAxisAlignment: (currentMessage.sender ==
                                        widget.userModel.uid)
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: responsiveDesign(context, 5),
                                      horizontal: responsiveDesign(context, 10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: responsiveDesign(context, 10),
                                      horizontal: responsiveDesign(context, 10),
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: (currentMessage.sender ==
                                              widget.userModel.uid)
                                          ? kSecondaryGradient
                                          : LinearGradient(colors: [
                                              const Color.fromARGB(
                                                  255, 76, 74, 74),
                                              const Color.fromARGB(
                                                  255, 168, 159, 159)
                                            ]),
                                      color: (currentMessage.sender !=
                                              widget.userModel.uid)
                                          ? Colors.grey
                                          : null,
                                      borderRadius: (currentMessage.sender ==
                                              widget.userModel.uid)
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(
                                                responsiveDesign(context, 10),
                                              ),
                                              topRight: Radius.circular(
                                                responsiveDesign(context, 10),
                                              ),
                                              bottomLeft: Radius.circular(
                                                responsiveDesign(context, 10),
                                              ),
                                            )
                                          : BorderRadius.only(
                                              bottomLeft: Radius.circular(
                                                responsiveDesign(context, 10),
                                              ),
                                              topRight: Radius.circular(
                                                responsiveDesign(context, 10),
                                              ),
                                              bottomRight: Radius.circular(
                                                responsiveDesign(context, 10),
                                              ),
                                            ),
                                    ),
                                    child: Text(
                                      currentMessage.text.toString(),
                                      style: TextStyle(
                                        fontSize: responsiveDesign(context, 18),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "An error occurred! Please check your internet connection.",
                            ),
                          );
                        } else {
                          return Center(
                            child: Text("Say hi to your new friend"),
                          );
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: responsiveDesign(context, 10),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            responsiveDesign(context, 30)),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      margin: EdgeInsets.only(
                        left: responsiveDesign(context, 15),
                        right: responsiveDesign(context, 5),
                        top: responsiveDesign(context, 15),
                        bottom: responsiveDesign(context, 15),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: responsiveDesign(context, 15),
                        vertical: responsiveDesign(context, 5),
                      ),
                      child: TextField(
                        controller: messageController,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter message",
                          hintStyle: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(responsiveDesign(context, 30)),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    margin: EdgeInsets.only(
                      right: responsiveDesign(context, 15),
                    ),
                    child: IconButton(
                      onPressed: () {
                        sendMessage();
                      },
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
