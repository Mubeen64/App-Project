// import 'package:flutter/widgets.dart';

// class SizeConfig {

//   void init(BuildContext context) {
//      double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     double blockSizeHorizontal = screenWidth / 100;
//     double blockSizeVertical = screenHeight / 100;

//     double textMultiplier = blockSizeVertical;
//     double imageSizeMultiplier = blockSizeHorizontal;
//     double heightMultiplier = blockSizeVertical;

//     // You can define additional size multipliers based on your needs
//   }
// }

// class Sizes {
//   static double getSize(int size) {
//     return SizeConfig.textMultiplier * size;
//   }
// }

// // Example usage:
// // SizeConfig().init(context); // Call this in your main.dart or the root widget's build method

// // Then, you can use Sizes.getSize() to get a responsive size:
// // double fontSize = Sizes.getSize(16);
// // double iconSize = Sizes.getSize(24);
// // double padding = Sizes.getSize(8);
