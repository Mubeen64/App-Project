class MessageModel {
  String? sender;
  String? text;
  bool? seen;
  DateTime? createon;
  String? messageid;

  MessageModel(
      {this.sender, this.text, this.seen, this.createon, this.messageid});

  MessageModel.fromMap(Map<String, dynamic> map) {
    sender = map['sender'];
    text = map['text'];
    seen = map['seen'];
    createon = map['createon'].toDate();
    messageid = map['messageid'];
  }
  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'text': text,
      'seen': seen,
      'createon': createon,
      'messageid': messageid
    };
  }
}
