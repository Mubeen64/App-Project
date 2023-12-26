class ChatRoomModel {
  String? chatroomid;
  Map<String, dynamic>? participants;
  String? lastMessage;
  List<dynamic>? users;
  DateTime? createdon;

  ChatRoomModel(
      {this.chatroomid,
      this.participants,
      this.lastMessage,
      this.users,
      this.createdon});

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatroomid = map['chatroomid'];
    participants = map['participants'];
    lastMessage = map['lastMesssage'];
    users = map['users'];
    createdon = map['createdon'].toDate();
  }
  Map<String, dynamic> toMap() {
    return {
      'chatroomid': chatroomid,
      'participants': participants,
      'lastMesssage': lastMessage,
      'users': users,
      'createdon': createdon,
    };
  }
}
