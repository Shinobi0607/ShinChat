import 'package:whatsapp_ui/common/enum/message_enum.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime timeSent;
  final String messageId;
  final MessageEnum type;
  final bool isSeen;
  final String repliedMessage;
  final String repliedTo;
  final MessageEnum repliedMessageType;
  Message({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timeSent,
    required this.messageId,
    required this.type,
    required this.isSeen,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'type': type.type,
      'isSeen': isSeen,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType': repliedMessageType.type,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      text: map['text'] as String,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      messageId: map['messageId'] as String,
      type: (map['type'] as String).toEnum(),
      isSeen: map['isSeen'] as bool,
      repliedMessage: map['repliedMessage'] as String,
      repliedTo: map['repliedTo'] as String,
      repliedMessageType:(map['repliedMessageType'] as String).toEnum(), 
    );
  }

}
