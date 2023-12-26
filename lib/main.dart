// import 'package:chat_app/models/firebaseHelper.dart';
// import 'package:chat_app/models/user_model.dart';
// import 'package:chat_app/pages/home_page.dart';
// import 'package:chat_app/pages/login_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:uuid/uuid.dart';

// Uuid uuid = Uuid();
// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   User? currentUser = FirebaseAuth.instance.currentUser;
//   if (currentUser != null) {
//     UserModel? thisUserModel =
//         await FirebaseHelper.getUserModelById(currentUser.uid);
//     if (thisUserModel != null) {
//       runApp(
//           MyAppLoggedIn(firebaseuser: currentUser, userModel: thisUserModel));
//     } else {
//       runApp(MyApp());
//     }
//   } else {
//     runApp(MyApp());
//   }
// }

// var KColorScheme =
//     ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 92, 21, 173));
// var kDarkColorScheme = ColorScheme.fromSeed(
//     brightness: Brightness.dark, seedColor: Color.fromARGB(255, 5, 99, 125));

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LoginPage(),
//       darkTheme: ThemeData.dark().copyWith(
//           useMaterial3: true,
//           colorScheme: kDarkColorScheme,
//           cardTheme: CardTheme().copyWith(
//               color: kDarkColorScheme.secondaryContainer,
//               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
//           elevatedButtonTheme: ElevatedButtonThemeData(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: kDarkColorScheme.primaryContainer,
//                   foregroundColor: kDarkColorScheme.onPrimaryContainer)),
//           textTheme: ThemeData().textTheme.copyWith(
//               titleLarge: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: KColorScheme.onSecondaryContainer,
//                   fontSize: 17))),
//       theme: ThemeData().copyWith(
//         useMaterial3: true,
//         colorScheme: KColorScheme,
//         appBarTheme: AppBarTheme().copyWith(
//           backgroundColor: KColorScheme.onPrimaryContainer,
//           foregroundColor: KColorScheme.primaryContainer,
//         ),
//         cardTheme: CardTheme().copyWith(
//           color: KColorScheme.secondaryContainer,
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: KColorScheme.primaryContainer,
//           ),
//         ),
//         textTheme: ThemeData().textTheme.copyWith(
//               titleLarge: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: KColorScheme.onSecondaryContainer,
//                 fontSize: 17,
//               ),
//             ),
//         primaryTextTheme: ThemeData().textTheme.copyWith(
//               titleLarge: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: KColorScheme.onSecondaryContainer,
//                 fontSize: 30,
//               ),
//             ),
//         bottomNavigationBarTheme: BottomNavigationBarThemeData(
//           backgroundColor: KColorScheme.primary,
//           selectedItemColor: KColorScheme.secondaryContainer,
//           unselectedItemColor: Colors.grey,
//         ),
//       ),
//       themeMode: ThemeMode.system,
//     );
//   }
// }

// class MyAppLoggedIn extends StatelessWidget {
//   final User firebaseuser;
//   final UserModel userModel;
//   MyAppLoggedIn({required this.firebaseuser, required this.userModel});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(firebaseUser: firebaseuser, userModel: userModel),
//       theme: ThemeData().copyWith(
//         useMaterial3: true,
//         colorScheme: KColorScheme,
//         appBarTheme: AppBarTheme().copyWith(
//           backgroundColor: KColorScheme.onPrimaryContainer,
//           foregroundColor: KColorScheme.primaryContainer,
//         ),
//         cardTheme: CardTheme().copyWith(
//           color: KColorScheme.secondaryContainer,
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: KColorScheme.primaryContainer,
//           ),
//         ),
//         textTheme: ThemeData().textTheme.copyWith(
//               titleLarge: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: KColorScheme.onSecondaryContainer,
//                 fontSize: 17,
//               ),
//             ),
//         primaryTextTheme: ThemeData().textTheme.copyWith(
//               titleLarge: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: KColorScheme.onSecondaryContainer,
//                 fontSize: 30,
//               ),
//             ),
//         bottomNavigationBarTheme: BottomNavigationBarThemeData(
//           backgroundColor: KColorScheme.primary,
//           selectedItemColor: KColorScheme.secondaryContainer,
//           unselectedItemColor: Colors.grey,
//         ),
//       ),
//       themeMode: ThemeMode.system,
//     );
//   }
// }
import 'package:chat_app/models/firebaseHelper.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    UserModel? thisUserModel =
        await FirebaseHelper.getUserModelById(currentUser.uid);
    if (thisUserModel != null) {
      runApp(
          MyAppLoggedIn(firebaseuser: currentUser, userModel: thisUserModel));
    } else {
      runApp(MyApp());
    }
  } else {
    runApp(MyApp());
  }
}

var kSecondaryGradient = LinearGradient(
  colors: [
    Color.fromARGB(255, 235, 138, 240),
    Color.fromARGB(255, 130, 12, 149),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: ThemeData.dark().colorScheme.copyWith(
                primary: Color.fromARGB(255, 16, 66, 80),
                secondary: Color.fromARGB(255, 5, 99, 125),
                onSecondary: Colors.white,
                onPrimary: Colors.white,
              ),
          cardTheme: CardTheme().copyWith(
            color: Color.fromARGB(255, 5, 99, 125),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 5, 99, 125),
              foregroundColor: Colors.white,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
          primaryTextTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 20, 19, 19),
                  fontSize: 30,
                ),
              ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color.fromARGB(255, 5, 99, 125),
            selectedItemColor: const Color.fromARGB(255, 91, 90, 90),
            unselectedItemColor: Colors.grey,
          ),
        ),
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: ThemeData.light().colorScheme.copyWith(
                primary: Color.fromARGB(255, 165, 23, 172),
                secondary: Color.fromARGB(255, 122, 14, 116),
                onSecondary: Colors.white,
                onPrimary: Colors.white,
              ),
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: Color.fromARGB(255, 165, 23, 172),
            foregroundColor: Colors.white,
          ),
          cardTheme: CardTheme().copyWith(
            color: Colors.grey[200],
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 165, 23, 172),
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
          primaryTextTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color.fromARGB(255, 122, 14, 116),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
          ),
        ),
        themeMode: ThemeMode.system,
      ),
      designSize: Size(411, 843),
    );
  }
}

class MyAppLoggedIn extends StatelessWidget {
  final User firebaseuser;
  final UserModel userModel;
  MyAppLoggedIn({required this.firebaseuser, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(firebaseUser: firebaseuser, userModel: userModel),
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: ThemeData.dark().colorScheme.copyWith(
                primary: Color.fromARGB(255, 16, 66, 80),
                secondary: Color.fromARGB(255, 5, 99, 125),
                onSecondary: Colors.white,
                onPrimary: Colors.white,
              ),
          cardTheme: CardTheme().copyWith(
            color: Color.fromARGB(255, 5, 99, 125),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 5, 99, 125),
              foregroundColor: Colors.white,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
          primaryTextTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 20, 19, 19),
                  fontSize: 30,
                ),
              ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color.fromARGB(255, 5, 99, 125),
            selectedItemColor: const Color.fromARGB(255, 91, 90, 90),
            unselectedItemColor: Colors.grey,
          ),
        ),
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: ThemeData.light().colorScheme.copyWith(
                primary: Color.fromARGB(255, 92, 21, 173),
                secondary: Color.fromARGB(255, 5, 99, 125),
                onSecondary: Colors.white,
                onPrimary: Colors.white,
              ),
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: Color.fromARGB(255, 92, 21, 173),
            foregroundColor: Colors.white,
          ),
          cardTheme: CardTheme().copyWith(
            color: Colors.grey[200],
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 92, 21, 173),
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
          primaryTextTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color.fromARGB(255, 92, 21, 173),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
          ),
        ),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
