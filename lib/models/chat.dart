// ignore_for_file: constant_identifier_names

enum MessageType {
  TEXT,
  IMAGE,
  VIDEO,
}

/// [Chat]
/// Chat Model for defining the chat data
class Chat {
  final String senderName;
  final String senderid;
  final String message;
  final MessageType type;
  final DateTime time;
  Chat({
    required this.senderName,
    required this.senderid,
    required this.message,
    this.type = MessageType.TEXT,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'sender_name': senderName,
      'sender_id': senderid,
      'message': message,
      'time': time.toIso8601String(),
      'message_type': type.name,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      senderName: map['sender_name'],
      senderid: map['sender_id'],
      message: map['message'],
      time: DateTime.parse(map['time']),
      // type: MessageType.values.,
    );
  }
}
