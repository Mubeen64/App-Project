// import 'package:chat_app/models/UIHelper.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class HelpPage extends StatefulWidget {
//   const HelpPage({super.key});

//   @override
//   State<HelpPage> createState() => _HelpPageState();
// }

// class _HelpPageState extends State<HelpPage> {

//   TextEditingController email = TextEditingController();
//   TextEditingController message = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Help"),
//         ),
//         body: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 80,
//                 ),
//                 Text(
//                   "Contact Us",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text("Get in touch, we'd love to hear from you"),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Card(
//                     elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(20),
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
//                                 controller: email,
//                                 decoration: InputDecoration(
//                                   labelText: "Email Address",
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             height: 300,
//                             decoration: BoxDecoration(
//                               color: Colors.grey[200],
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 8.0),
//                               child: TextField(
//                                 controller: message,
//                                 decoration: InputDecoration(
//                                   labelText: "Message",
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 email.clear();
//                                 message.clear();
//                               });
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: Text(
//                                       "Success",
//                                       style: TextStyle(
//                                         color:
//                                             Color.fromARGB(255, 250, 186, 249),
//                                       ),
//                                     ),
//                                     titleTextStyle: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20,
//                                     ),
//                                     actions: [
//                                       TextButton(
//                                           child: Text(
//                                             "OK",
//                                             style: TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 250, 186, 249),
//                                             ),
//                                           ),
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           })
//                                     ],
//                                     backgroundColor:
//                                         Color.fromARGB(255, 74, 31, 79),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(20)),
//                                     ),
//                                     content: Text(
//                                       "Sent successfully",
//                                       style: TextStyle(
//                                         color:
//                                             Color.fromARGB(255, 250, 186, 249),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                             child: Container(
//                               width: 250,
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
//                                   "Send",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ))
//               ],
//             ),
//           ),
//         ));
//   }
// }
// import 'package:chat_app/models/UIHelper.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:chat_app/main.dart';

// class HelpPage extends StatefulWidget {
//   const HelpPage({super.key});

//   @override
//   State<HelpPage> createState() => _HelpPageState();
// }

// class _HelpPageState extends State<HelpPage> {
//   TextEditingController email = TextEditingController();
//   TextEditingController message = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Help"),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 80,
//               ),
//               Text(
//                 "Contact Us",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text("Get in touch, we'd love to hear from you"),
//               SizedBox(
//                 height: 30,
//               ),
//               Card(
//                 elevation: 4.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           border: Border.all(color: Colors.white),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 8.0),
//                           child: TextField(
//                             controller: email,
//                             decoration: InputDecoration(
//                               labelText: "Email Address",
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Container(
//                         height: 300,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           border: Border.all(color: Colors.white),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 8.0),
//                           child: TextField(
//                             controller: message,
//                             decoration: InputDecoration(
//                               labelText: "Message",
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             email.clear();
//                             message.clear();
//                           });
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: Text(
//                                   "Success",
//                                   style: TextStyle(
//                                     color:
//                                         Theme.of(context).colorScheme.onPrimary,
//                                   ),
//                                 ),
//                                 titleTextStyle: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                                 actions: [
//                                   TextButton(
//                                     child: Text(
//                                       "OK",
//                                       style: TextStyle(
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .onPrimary,
//                                       ),
//                                     ),
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                   ),
//                                 ],
//                                 backgroundColor:
//                                     Theme.of(context).colorScheme.primary,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(20)),
//                                 ),
//                                 content: Text(
//                                   "Sent successfully",
//                                   style: TextStyle(
//                                     color:
//                                         Theme.of(context).colorScheme.onPrimary,
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                         child: Container(
//                           width: 250,
//                           padding: EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             gradient: LinearGradient(
//                               colors: [
//                                 Theme.of(context).colorScheme.secondary,
//                                 Theme.of(context).colorScheme.primary,
//                               ],
//                             ),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "Send",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color:
//                                     Theme.of(context).colorScheme.onSecondary,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
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

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController message = TextEditingController();

  double responsiveSize(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage / 100.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 80.h),
              Text(
                "Contact Us",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              SizedBox(height: 10.h),
              Text(
                "Get in touch, we'd love to hear from you",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              SizedBox(height: 30.h),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(responsiveSize(context, 12.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(responsiveSize(context, 20)),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(
                              responsiveSize(context, 12)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: responsiveSize(context, 8.0)),
                          child: TextField(
                            controller: email,
                            decoration: InputDecoration(
                              labelText: "Email Address",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        height: 300.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(
                              responsiveSize(context, 12)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: responsiveSize(context, 8.0)),
                          child: TextField(
                            controller: message,
                            decoration: InputDecoration(
                              labelText: "Message",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            email.clear();
                            message.clear();
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Success",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                titleTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      "OK",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          responsiveSize(context, 20))),
                                ),
                                content: Text(
                                  "Sent successfully",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 250.w,
                          padding: EdgeInsets.all(responsiveSize(context, 5)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                responsiveSize(context, 12)),
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.secondary,
                                Theme.of(context).colorScheme.primary,
                              ],
                            ),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Send",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ),
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
    );
  }
}
