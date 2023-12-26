import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  static Future<UserModel?> getUserModelById(String uid) async {
    UserModel? userModel;
    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (docSnap.exists) {
      userModel = UserModel.frommap(docSnap.data() as Map<String, dynamic>);
    }
    return userModel;
  }

  static Future<void> deleteChatRoom(String chatRoomId) async {
    try {
      // Reference to the chat room document
      DocumentReference chatRoomRef =
          FirebaseFirestore.instance.collection("chatrooms").doc(chatRoomId);

      // Delete the chat room document
      await chatRoomRef.delete();

      // You may also want to delete messages associated with this chat room.
      // Assuming your messages are stored in a "messages" subcollection within each chat room.
      // You can add additional logic here to delete messages.

      print("Chat room deleted successfully.");
    } catch (e) {
      // Handle any errors that may occur during deletion
      print("Error deleting chat room: $e");
    }
  }
}
