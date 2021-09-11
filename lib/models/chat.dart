import 'dart:convert';

class Chat {
  final String senderName;
  final String receiverId;
  final String? message;
  final DateTime timeStamp;
  Chat({
    required this.senderName,
    required this.receiverId,
    this.message,
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderName': senderName,
      'receiverId': receiverId,
      'message': message,
      'timeStamp': timeStamp.millisecondsSinceEpoch,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      senderName: map['senderName'],
      receiverId: map['receiverId'],
      message: map['message'],
      timeStamp: DateTime.fromMillisecondsSinceEpoch(map['timeStamp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source));
}
