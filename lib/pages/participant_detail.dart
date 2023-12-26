// import 'package:chat_app/models/chat_room_model.dart';
// import 'package:chat_app/models/user_model.dart';
// import 'package:chat_app/pages/home_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ParticipantDetail extends StatefulWidget {
//   const ParticipantDetail(
//       {super.key,
//       required this.firebaseUser,
//       required this.targetUser,
//       required this.chatroom,
//       required this.userModel});
//   final UserModel targetUser;
//   final ChatRoomModel chatroom;
//   final User firebaseUser;
//   final UserModel userModel;

//   @override
//   State<ParticipantDetail> createState() => _ParticipantDetailState();
// }

// class _ParticipantDetailState extends State<ParticipantDetail> {
//   DateTime dateToFormat = DateTime.now();

//   DateFormat dateFormat = DateFormat('MMM d, y');

//   String formattedDate = '';

//   @override
//   Widget build(BuildContext context) {
//     formattedDate = dateFormat.format(dateToFormat);
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 247, 245, 245),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(20),
//                 height: 350,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 child: Center(
//                   child: Column(children: [
//                     // Back button
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.arrow_back),
//                           onPressed: () {
//                             // Handle the back button action here
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) {
//                                   return HomePage(
//                                     firebaseUser: widget.firebaseUser,
//                                     userModel: widget.userModel,
//                                   );
//                                 },
//                               ),
//                             );
//                           },
//                         ),
//                         PopupMenuButton(itemBuilder: (context) {
//                           return [
//                             PopupMenuItem(
//                               child: Text(
//                                 "Block",
//                               ),
//                             )
//                           ];
//                         })
//                       ],
//                     ),
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundImage: NetworkImage(
//                         widget.targetUser.profilePic.toString(),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       widget.targetUser.fullname.toString(),
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       widget.targetUser.email.toString(),
//                       style: TextStyle(fontSize: 15),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Column(children: [
//                             Icon(Icons.call),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text("Audio")
//                           ]),
//                           Column(children: [
//                             Icon(Icons.video_call_rounded),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text("Video")
//                           ]),
//                           Column(children: [
//                             Icon(Icons.search),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text("Search")
//                           ]),
//                         ])
//                   ]),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(color: Colors.white),
//                 height: 90,
//                 width: double.infinity,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Available",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(formattedDate,
//                         style: TextStyle(
//                             fontSize: 15, fontWeight: FontWeight.bold))
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 height: 300,
//                 width: double.infinity,
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.alarm),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         const Text(
//                           "Mute Notifications",
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 25,
//                     ),
//                     Row(
//                       children: [
//                         Icon(Icons.music_note),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Custom Notifications",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Text("Enabled")
//                             ])
//                       ],
//                     ),
//                     SizedBox(
//                       height: 25,
//                     ),
//                     Row(
//                       children: [
//                         Icon(Icons.browse_gallery),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Media Visibility",
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.black,
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 25,
//                     ),
//                     Row(
//                       children: [
//                         Icon(Icons.star_border),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Starred Messages",
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 160,
//                         ),
//                         Text("1")
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 120,
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.lock),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Encryption",
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 25,
//                     ),
//                     Row(
//                       children: [
//                         Icon(Icons.lock_clock),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Disappearing messages",
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 120,
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.block, color: Colors.red),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Block ${widget.targetUser.fullname}",
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.red,
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.thumb_down,
//                           color: Colors.red,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Report ${widget.targetUser.fullname}",
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Ensure you have necessary imports

class ParticipantDetail extends StatefulWidget {
  final UserModel targetUser;
  final ChatRoomModel chatroom;
  final User firebaseUser;
  final UserModel userModel;

  ParticipantDetail({
    Key? key,
    required this.firebaseUser,
    required this.targetUser,
    required this.chatroom,
    required this.userModel,
  }) : super(key: key);

  @override
  State<ParticipantDetail> createState() => _ParticipantDetailState();
}

class _ParticipantDetailState extends State<ParticipantDetail> {
  late DateFormat dateFormat;
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    dateFormat = DateFormat('MMM d, y'); // Initialize dateFormat
    formattedDate = dateFormat.format(DateTime.now()); // Format current date
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60.r,
              backgroundImage:
                  NetworkImage(widget.targetUser.profilePic.toString()),
            ),
            SizedBox(height: 24.h),
            Text(
              widget.targetUser.fullname.toString(),
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              widget.targetUser.email.toString(),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 32.h),
            // Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    // Add call functionality
                  },
                  icon: Icon(Icons.call),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                IconButton(
                  onPressed: () {
                    // Add video call functionality
                  },
                  icon: Icon(Icons.video_call_rounded),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                IconButton(
                  onPressed: () {
                    // Add search or more info functionality
                  },
                  icon: Icon(Icons.search),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
            Divider(),
            ListTile(
              title: Text("Available"),
              subtitle: Text(formattedDate),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications_off),
              title: Text("Mute Notifications"),
              onTap: () {
                // Implement mute notifications
              },
            ),
            ListTile(
              leading: Icon(Icons.music_note),
              title: Text("Custom Notifications"),
              onTap: () {
                // Implement mute notifications
              },
            ),
            ListTile(
              leading: Icon(Icons.browse_gallery),
              title: Text("Media Visibility"),
              onTap: () {
                // Implement media visibility
              },
            ),
            ListTile(
              leading: Icon(Icons.star_border),
              title: Text("Starred Messages"),
              onTap: () {
                // Implement starred messages
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text("Encryption"),
              onTap: () {
                // Implement encryption details or modal
              },
            ),
            ListTile(
              leading: Icon(Icons.lock_clock),
              title: Text("Disappearing messages"),
              onTap: () {
                // Implement mute notifications
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.block, color: Colors.red),
              title: Text("Block ${widget.targetUser.fullname}"),
              onTap: () {
                // Implement block action
              },
            ),
            ListTile(
              leading: Icon(Icons.thumb_down, color: Colors.red),
              title: Text("Report ${widget.targetUser.fullname}"),
              onTap: () {
                // Implement report action
              },
            ),
          ],
        ),
      ),
    );
  }
}
