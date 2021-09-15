import 'dart:convert';

class Chat {
  final String senderName;
  final String senderid;
  final String message;
  final DateTime time;
  Chat({
    required this.senderName,
    required this.senderid,
    required this.message,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderName': senderName,
      'senderid': senderid,
      'message': message,
      'time': time.millisecondsSinceEpoch * 1000,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      senderName: map['senderName'],
      senderid: map['senderid'],
      message: map['message'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] * 1000),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source));
}
